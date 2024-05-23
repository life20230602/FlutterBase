import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';

class DecryptUtils {
  ///aes解密
  static String decryptAes(String input, String data) {
    var key = Key.fromUtf8(input);
    final encrypt = Encrypter(AES(key, mode: AESMode.ecb));
    var result = encrypt.decrypt(Encrypted.fromBase64(data));
    return result;
  }

  ///aes解密
  static String decryptAesCbc(String input, String ivData, Uint8List data) {
    var key = Key.fromUtf8(input);
    final encrypt = Encrypter(AES(key, mode: AESMode.cbc));
    var result = encrypt.decrypt(Encrypted(data), iv: IV.fromUtf8(ivData));
    return result;
  }

  ///aes解密
  static String decryptAesCbcStr(String input, String ivData, String data) {
    var key = Key.fromUtf8(input);
    final encrypt = Encrypter(AES(key, mode: AESMode.cbc));
    var result = encrypt.decrypt(Encrypted.fromBase64(data), iv: IV.fromUtf8(ivData));
    return result;
  }

  ///aes加密
  static String encryptAesCbcStr(String input, String ivData, String data) {
    var key = Key.fromUtf8(input);
    final encrypt = Encrypter(AES(key, mode: AESMode.cbc));
    var result = encrypt.encrypt(data, iv: IV.fromUtf8(ivData)).base64;
    return result;
  }

  ///解密图片
  static Uint8List decryptImage(Uint8List data) {
    final length = data.length;
    for (int i = 0; i < length; i++) {
      data[i] = data[i] ^ 88;
    }
    return data;
  }

  ///md5加密
  static String md5Encode(String data) {
    return md5.convert(utf8.encode(data)).toString();
  }
}

extension DecryptExt on String {
  ///字符串转md5
  String toMd5() {
    return DecryptUtils.md5Encode(this);
  }

  ///解密接口数据
  String decryptApiData() {
    return DecryptUtils.decryptAesCbcStr("qrRCjxruBaInnSFv", "S58LowsUeDkyX4KT", this);
  }

  ///加密接口数据
  String encryptApiData() {
    return DecryptUtils.encryptAesCbcStr("qrRCjxruBaInnSFv", "S58LowsUeDkyX4KT", this);
  }
}

extension Unit8ListDecryptExt on Uint8List {
  ///解密host存储桶数据
  String decryptHostData() {
    return DecryptUtils.decryptAesCbc("2acf7e91e9864673", "1c29882d3ddfcfd6", this);
  }
}
