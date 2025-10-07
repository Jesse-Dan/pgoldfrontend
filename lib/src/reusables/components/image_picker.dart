// ignore_for_file: library_private_types_in_public_api

import 'dart:developer' as developer;
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../config/color_config.dart';
import '../../services/cloudinary_service.dart';
import '../utils/show_text.dart';
import 'app_loading_indicator.dart';
import 'image_viewer.dart';

enum UploadMode { single, multiple }

enum FilePickType { all, images, documents }

enum FileSourceType { all, gallery, files }

class AppFilePicker extends ConsumerStatefulWidget {
  const AppFilePicker({
    super.key,
    required this.onUploadComplete,
    this.mode = UploadMode.single,
    this.maxFiles,
    this.initialPaths = const [],
    this.readOnly = false,
    this.fileType = FilePickType.all,
    this.sourceType = FileSourceType.all,
  });

  final Function(List<String>) onUploadComplete;
  final UploadMode mode;
  final int? maxFiles;
  final List<String> initialPaths;
  final bool readOnly;
  final FilePickType fileType;
  final FileSourceType sourceType;

  @override
  _AppFilePickerState createState() => _AppFilePickerState();
}

class _AppFilePickerState extends ConsumerState<AppFilePicker> {
  late List<String> _uploadedPaths;
  final _cloudinaryService = CloudinaryService();
  bool _isUploading = false;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _uploadedPaths = widget.initialPaths;
    developer.log('Initialized with: $_uploadedPaths');
  }

  bool get _canUploadMore {
    if (widget.mode == UploadMode.single) return false;
    if (widget.maxFiles == null) return true;
    return _uploadedPaths.length < widget.maxFiles!;
  }

  Future<void> _uploadFiles(List<File> files) async {
    if (files.isEmpty) return;

    setState(() => _isUploading = true);
    try {
      for (final file in files) {
        final url = await _cloudinaryService.uploadFile(file: file);
        setState(() {
          if (widget.mode == UploadMode.single) {
            _uploadedPaths = [url];
          } else {
            _uploadedPaths = [..._uploadedPaths, url];
          }
        });
      }
      widget.onUploadComplete(_uploadedPaths);
    } catch (e) {
      showText('Upload failed: ${e.toString()}');
    } finally {
      setState(() => _isUploading = false);
    }
  }

  void _handleRemove(int index) {
    if (widget.readOnly) {
      showText("This field is read-only");
      return;
    }
    setState(() => _uploadedPaths.removeAt(index));
    widget.onUploadComplete(_uploadedPaths);
  }

  Future<void> _pickFiles() async {
    if (widget.readOnly) {
      showText("This field is read-only");
      return;
    }

    try {
      List<File> files = [];

      if (widget.sourceType == FileSourceType.gallery) {
        final picked = await _imagePicker.pickMultiImage(imageQuality: 75);

        if (picked.isEmpty) return;
        files = picked.map((x) => File(x.path)).toList();
      } else {
        List<String> allowedExtensions;
        switch (widget.fileType) {
          case FilePickType.images:
            allowedExtensions = ['jpg', 'jpeg', 'png'];
            break;
          case FilePickType.documents:
            allowedExtensions = ['pdf', 'doc', 'docx', 'txt'];
            break;
          case FilePickType.all:
            allowedExtensions = [
              'jpg',
              'jpeg',
              'png',
              'pdf',
              'doc',
              'docx',
              'txt',
            ];
            break;
        }

        FilePickerResult? result = await FilePicker.platform.pickFiles(
          allowMultiple: widget.mode == UploadMode.multiple,
          type: FileType.custom,
          allowedExtensions: allowedExtensions,
        );

        if (result == null) {
          developer.log('User cancelled file picking');
          return;
        }

        files = result.paths.whereType<String>().map((p) => File(p)).toList();
      }

      await _uploadFiles(files);
    } catch (e) {
      developer.log('Error picking files: $e');
      showText('Error picking files: ${e.toString()}');
    }
  }

  bool _isImage(String url) {
    final ext = url.split('.').last.toLowerCase();
    return ['jpg', 'jpeg', 'png'].contains(ext);
  }

  Widget _buildFilePreview(String path, int index) {
    final isImage = _isImage(path);
    return Stack(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.shade200,
          ),
          child:
              isImage
                  ? AppImageViewer(
                    path,
                    height: 100,
                    width: 100,
                    borderRadius: BorderRadius.circular(8),
                    fit: BoxFit.cover,
                  )
                  : Center(
                    child: Icon(
                      Icons.insert_drive_file,
                      size: 40,
                      color: Colors.blue,
                    ),
                  ),
        ),
        if (!widget.readOnly)
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: () => _handleRemove(index),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: const Icon(Icons.close, size: 20, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSingleUpload() {
    return Column(
      children: [
        if (_uploadedPaths.isNotEmpty)
          _buildFilePreview(_uploadedPaths.first, 0)
        else
          const Icon(Icons.file_present, size: 100),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _isUploading ? null : _pickFiles,
          child: Text(_uploadedPaths.isEmpty ? 'Upload File' : 'Replace File'),
        ),
      ],
    );
  }

  Widget _buildMultipleUpload() {
    return Column(
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              _uploadedPaths
                  .asMap()
                  .entries
                  .map((entry) => _buildFilePreview(entry.value, entry.key))
                  .toList(),
        ),
        if (_canUploadMore) ...[
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _isUploading ? null : _pickFiles,
            child: const Text('Add More Files'),
          ),
        ],
        if (widget.maxFiles != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              '${_uploadedPaths.length}/${widget.maxFiles} files uploaded',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child:
          _isUploading
              ? Center(
                child: AppLoadingIndicator(
                  text: "Uploading...\nDo not close sheet.",
                  textColor: ColorConfig.primaryBlueLight,
                ),
              )
              : widget.mode == UploadMode.single
              ? _buildSingleUpload()
              : _buildMultipleUpload(),
    );
  }
}
