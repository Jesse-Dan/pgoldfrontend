import 'dart:math';

import 'package:uuid/uuid.dart';

class Generators {
  static String generateOtp(int length) {
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random.secure();

    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => characters.codeUnitAt(random.nextInt(characters.length)),
      ),
    );
  }

  static String generateCustomID([String prefixText = "Custom"]) {
    var prefix = "$prefixText-";
    final uuid = Uuid().v4().replaceAll('-', '').toUpperCase();
    final randomPart = uuid.substring(0, 7);

    return prefix + randomPart;
  }
}
