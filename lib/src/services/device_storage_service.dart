// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

abstract class DeviceStorage {
  // Get the directory path
  static Future<String> get _directoryPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<String> saveStringToFile({
    required String content,
    required String fileName,
    required String extension,
  }) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = path.join(directory.path, '$fileName.$extension');
    final file = File(filePath);
    await file.writeAsString(content);
    return file.path;
  }

  // Read string from file
  static Future<(String, File)> readStringFromFile(String fileName) async {
    final directory = await _directoryPath;
    final filePath = path.join(directory, fileName);
    final file = File(filePath);
    if (!await file.exists()) {
      throw Exception('File not found.');
    }
    final content = await file.readAsString();
    return (content, file);
  }

  // Save JSON to file
  static Future<void> saveJsonToFile(
      Map<String, dynamic> jsonData,
      String fileName,
      ) async {
    final directory = await _directoryPath;
    final filePath = path.join(directory, '$fileName.json');
    final jsonString = jsonEncode(jsonData);
    final file = File(filePath);
    await file.writeAsString(jsonString);
  }

  // Read JSON from file
  static Future<Map<String, dynamic>> readJsonFromFile(String fileName) async {
    final directory = await _directoryPath;
    final filePath = path.join(directory, '$fileName.json');
    final file = File(filePath);
    if (!await file.exists()) {
      throw Exception('File not found.');
    }
    final jsonString = await file.readAsString();
    return jsonDecode(jsonString);
  }

  // Save image to file
  static Future<void> saveImageToFile(ui.Image image, String fileName) async {
    final directory = await _directoryPath;
    final filePath = path.join(directory, '$fileName.png');
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    if (bytes == null) {
      throw Exception('Failed to convert image to bytes.');
    }
    final file = File(filePath);
    await file.writeAsBytes(bytes.buffer.asUint8List());
  }

  // Check if file exists
  static Future<bool> fileExists(String fileName) async {
    final directory = await _directoryPath;
    final filePath = path.join(directory, fileName);
    final file = File(filePath);
    final exists = await file.exists();
    return exists;
  }

  // Delete file
  static Future<void> deleteFile(String fileName) async {
    final directory = await _directoryPath;
    final filePath = path.join(directory, fileName);
    final file = File(filePath);
    if (!await file.exists()) {
      throw Exception('File not found.');
    }
    await file.delete();
  }
}
