import 'dart:convert';
import 'dart:io';
import 'package:barcode/barcode.dart';

import '../../services/device_storage_service.dart';

sealed class QrGenerator {
  static Future<String> generateAccessCode({required String code}) async {
    try {
      final qr = Barcode.qrCode();
      final data = {'code': code};

      final jsonData = jsonEncode(data);

      final svgCode = qr.toSvg(jsonData, width: 150, height: 150);

      const fileName = 'passcode';
      final filePath = await DeviceStorage.saveStringToFile(
        content: svgCode,
        fileName: fileName,
        extension: 'svg',
      );

      final savedFile = File(filePath);

      if (!savedFile.existsSync()) {
        throw Exception('Failed to save the QR code file.');
      }

      return await savedFile.readAsString();
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> generatePasscodeOld({
    required String code,
    required String userId,
    required String recipientRef,
    required DateTime date,
  }) async {
    try {
      final qr = Barcode.qrCode();
      final data = {
        'code': code,
        'user_id': userId,
        'recipient_ref': recipientRef,
        'date': date.toIso8601String(),
      };

      final jsonData = jsonEncode(data);

      final svgCode = qr.toSvg(jsonData, width: 150, height: 150);

      const fileName = 'passcode';
      final filePath = await DeviceStorage.saveStringToFile(
        content: svgCode,
        fileName: fileName,
        extension: 'svg',
      );

      final savedFile = File(filePath);

      if (!savedFile.existsSync()) {
        throw Exception('Failed to save the QR code file.');
      }

      return await savedFile.readAsString();
    } catch (e) {
      rethrow;
    }
  }
}
