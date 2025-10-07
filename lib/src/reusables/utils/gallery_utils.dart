import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pgoldapp/src/reusables/utils/show_text.dart';
import 'package:screenshot/screenshot.dart';

import '../../../main.dart';

class GalleryUtils {
  static final ScreenshotController _controller = ScreenshotController();

  static Future<void> captureAndSaveWidget({
    required BuildContext context,
    required Widget Function(Widget) builder,
    required Widget widget,
    String folderName = "AAACIfy",
    String? filePrefix,
  }) async {
    try {
      Uint8List? imageBytes = await _controller.captureFromWidget(
        builder(widget),
        delay: const Duration(milliseconds: 200),
      );

      final fileName =
          '${filePrefix ?? "screenshot"}_${DateTime.now().millisecondsSinceEpoch}.png';
      final Directory tempDir = await getTemporaryDirectory();
      final File file = File('${tempDir.path}/$fileName')
        ..writeAsBytesSync(imageBytes);

      final saveResult = await mediaStorePlugin.saveFile(
        tempFilePath: file.path,
        dirType: DirType.photo,
        dirName: DirType.photo.defaults,
        relativePath: folderName,
      );

      if (saveResult?.uri != null) {
        debugPrint('✅ Saved at ${saveResult!.uri}');
        showText("Image saved to gallery");
      } else {
        showText('Failed to save image');
      }
    } catch (e) {
      showText('Error while saving image');
    }
  }
}
