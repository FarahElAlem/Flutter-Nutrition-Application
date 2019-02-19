import 'package:encrypt/encrypt.dart';

class Encrypt {
  static final String key = '4AAFC77C23628AE7E10C7DACAB4C29B9';
  static final String iv = '8bytesiv';
  final encrypter = new Encrypter(new Salsa20(key, iv));

  String encrypt(String s) {
    return (s != null) ? encrypter.encrypt(s) : null;
  }

  String decrypt(String s) {
    return (s != null) ? encrypter.decrypt(s) : null;
  }
}
