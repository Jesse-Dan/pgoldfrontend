// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pgoldapp/src/reusables/extensions/context.dart';
import 'package:transparent_image/transparent_image.dart';

enum ImageResizeMode { cover, contain, stretch }

class AppImageViewer extends StatelessWidget {
  AppImageViewer(
    this.filePath, {
    super.key,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.cover,
    this.resizeMode = ImageResizeMode.cover,
    this.borderRadius,
    this.colorFilter,
    this.showFileTitle = true,
  }) {
    log(filePath, name: "filePath");
  }

  final String filePath;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit fit;
  final ImageResizeMode resizeMode;
  final BorderRadiusGeometry? borderRadius;
  final ColorFilter? colorFilter;
  final bool showFileTitle;

  bool get isNetwork => filePath.startsWith('http');
  bool get isSvg => filePath.endsWith('.svg');
  bool get isPdf => filePath.toLowerCase().endsWith('.pdf');
  bool get isDoc =>
      filePath.toLowerCase().endsWith('.doc') ||
      filePath.toLowerCase().endsWith('.docx');
  bool get isText => filePath.toLowerCase().endsWith('.txt');
  bool get isImage =>
      filePath.endsWith('.png') ||
      filePath.endsWith('.jpg') ||
      filePath.endsWith('.jpeg') ||
      filePath.endsWith('.gif');

  Future<void> _openFile(BuildContext context) async {
    try {
      String localPath = filePath;

      // If it's a network file, download it to temp directory
      if (isNetwork) {
        final response = await http.get(Uri.parse(filePath));
        if (response.statusCode == 200) {
          final tempDir = await getTemporaryDirectory();
          final ext = filePath.split('.').last;
          final file = File('${tempDir.path}/temp_file.$ext');
          await file.writeAsBytes(response.bodyBytes);
          localPath = file.path;
        } else {
          throw Exception("Failed to download file");
        }
      }

      final result = await OpenFilex.open(localPath);
      if (result.type != ResultType.done) {
        log(result.message);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open file: ${result.message}')),
        );
      }
    } catch (e) {
      log("Error opening file: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error opening file: $e")));
    }
  }

  Widget _buildDocViewer(BuildContext context) {
    String ext = filePath.split('.').last.toUpperCase();
    return GestureDetector(
      onTap: () => _openFile(context),
      child: Container(
        width: width ?? 120,
        height: height ?? 120,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          color: Colors.grey.shade100,
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isPdf
                  ? Icons.picture_as_pdf
                  : isText
                  ? Icons.description
                  : Icons.insert_drive_file,
              size: 40,
              color: isPdf ? Colors.red : Colors.blueGrey,
            ),
            Visibility(
              visible: showFileTitle,
              child: Column(
                children: [
                  const SizedBox(height: 4),
                  Text(
                    ext,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text('Tap to view', style: TextStyle(fontSize: 10)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageWidget(BuildContext context) {
    if (isSvg) {
      return SvgPicture.asset(
        filePath,
        width: width,
        height: height,
        color: color,
        fit: fit,
        colorFilter: colorFilter,
        placeholderBuilder:
            (context) => const Center(child: Icon(Icons.image_not_supported)),
      );
    } else if (isNetwork && isImage) {
      return CachedNetworkImage(
        imageUrl: filePath,
        fadeInDuration: Durations.long4,
        fadeInCurve: Curves.linear,
        width: width,
        height: height,
        fit: fit,
        placeholder:
            (context, url) => Center(
              child: ColoredBox(
                color: Colors.grey,
                child: SizedBox(width: context.width, height: height),
              ),
            ),
        errorWidget:
            (context, url, error) => const Icon(Icons.broken_image, size: 40),
      );
    } else if (filePath.contains("com.digitwhale")) {
      return FadeInImage(
        fit: fit,
        height: height,
        placeholder: MemoryImage(kTransparentImage),
        image: FileImage(File(filePath)),
      );
    } else {
      return FadeInImage(
        placeholder: MemoryImage(kTransparentImage),
        image: AssetImage(filePath),
        width: width,
        height: height,
        color: color,
        fit: fit,
        imageErrorBuilder:
            (context, error, stackTrace) =>
                const Icon(Icons.broken_image, size: 40),
      );
    }
  }

  AppImageViewer copyWith({
    String? filePath,
    double? width,
    double? height,
    Color? color,
    BoxFit? fit,
    ImageResizeMode? resizeMode,
    BorderRadiusGeometry? borderRadius,
    ColorFilter? colorFilter,
  }) {
    return AppImageViewer(
      filePath ?? this.filePath,
      width: width ?? this.width,
      height: height ?? this.height,
      color: color ?? this.color,
      fit: fit ?? this.fit,
      resizeMode: resizeMode ?? this.resizeMode,
      borderRadius: borderRadius ?? this.borderRadius,
      colorFilter: colorFilter ?? this.colorFilter,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!isImage && (isPdf || isDoc || isText)) {
      return _buildDocViewer(context);
    }

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      child: SizedBox(
        width: width,
        height: height,
        child: _buildImageWidget(context),
      ),
    );
  }
}
