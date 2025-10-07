import 'package:encrypt/encrypt.dart';

class EncryptionHelper {
  static final _key =
      Key.fromUtf8('32-char-key-here-1234567890abcdef'); // Must match PHP
  static final _iv = IV.fromUtf8('16-char-iv-heree'); // Must match PHP
  static final _encrypter = Encrypter(AES(_key, mode: AESMode.cbc));

  static Future<String> encrypt(String data) async {
    final encrypted = _encrypter.encrypt(data, iv: _iv);
    return encrypted.base64;
  }

  static String decrypt(String encryptedData) {
    final encrypted = Encrypted.fromBase64(encryptedData);
    return _encrypter.decrypt(encrypted, iv: _iv);
  }
}
