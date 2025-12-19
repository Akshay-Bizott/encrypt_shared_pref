import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final String _encryptionKeyKey = 'encryptionKey';
  final IV _iv = IV.fromLength(16);
  final _secureStorage = FlutterSecureStorage();
  Encrypter? _encrypter;

  SecureStorage() {
    loadEncryptionKey();
  }

  Future<void> loadEncryptionKey() async {
    String? encryptionKey = await _secureStorage.read(key: _encryptionKeyKey);
    if (encryptionKey == null) {
      // Generate a new encryption key if it doesn't exist
      final Uint8List newEncryptionKey = generateEncryptionKey();
      encryptionKey = base64Encode(newEncryptionKey);
      await _secureStorage.write(key: _encryptionKeyKey, value: encryptionKey);
    }

    final Uint8List keyBytes = base64Decode(encryptionKey);
    _encrypter = Encrypter(AES(Key(keyBytes)));
  }

  static Uint8List generateEncryptionKey() {
    final keyLength = 32; // 256 bits
    final secureRandom = Random.secure();
    final List<int> randomBytes = List<int>.generate(keyLength, (_) => secureRandom.nextInt(256));
    return Uint8List.fromList(randomBytes);
  }

  /// write and read String data
  Future<void> writeString({required String key, required String value, bool isEncrypted = true}) async {
    final jsonData = json.encode(value);
    if (isEncrypted) {
      final encryptedData = _encrypter?.encrypt(jsonData, iv: _iv).base64;
      await _secureStorage.write(key: key, value: encryptedData);
    } else {
      await _secureStorage.write(key: key, value: jsonData);
    }
  }

  Future<String?> readString({required String key, bool isEncrypted = true}) async {
    final encryptedData = await _secureStorage.read(key: key);
    if (encryptedData != null) {
      if (isEncrypted) {
        final decryptedData = _encrypter?.decrypt64(encryptedData, iv: _iv);
        return json.decode(decryptedData!) as String;
      } else {
        return json.decode(encryptedData) as String;
      }
    }
    return null;
  }

  /// write and read int data
  Future<void> writeInt({required String key, required int value, bool isEncrypted = true}) async {
    await writeString(key: key, value: value.toString(), isEncrypted: isEncrypted);
  }

  Future<int?> readInt({required String key, bool isEncrypted = true}) async {
    final stringValue = await readString(key: key, isEncrypted: isEncrypted);
    if (stringValue != null) {
      return int.tryParse(stringValue);
    }
    return null;
  }

  /// write and read bool data
  Future<void> writeBool({required String key, required bool value, bool isEncrypted = true}) async {
    await writeString(key: key, value: value.toString(), isEncrypted: isEncrypted);
  }

  Future<bool?> readBool({required String key, bool isEncrypted = true}) async {
    final stringValue = await readString(key: key, isEncrypted: isEncrypted);
    if (stringValue != null) {
      return stringValue.toLowerCase() == 'true';
    }
    return null;
  }

  /// write and read Map data
  Future<void> writeMap({required String key, required Map<String, dynamic> value, bool isEncrypted = true}) async {
    final jsonData = json.encode(value);
    if (isEncrypted) {
      final encryptedData = _encrypter?.encrypt(jsonData, iv: _iv).base64;
      await _secureStorage.write(key: key, value: encryptedData);
    } else {
      await _secureStorage.write(key: key, value: jsonData);
    }
  }

  Future<Map<String, dynamic>?> readMap({required String key, bool isEncrypted = true}) async {
    final encryptedData = await _secureStorage.read(key: key);
    if (encryptedData != null) {
      if (isEncrypted) {
        final decryptedData = _encrypter?.decrypt64(encryptedData, iv: _iv);
        return json.decode(decryptedData!) as Map<String, dynamic>;
      } else {
        return json.decode(encryptedData) as Map<String, dynamic>;
      }
    }
    return null;
  }

  /// write and read List data
  Future<void> writeList({required String key, required List<dynamic> value, bool isEncrypted = true}) async {
    final jsonData = json.encode(value);
    if (isEncrypted) {
      final encryptedData = _encrypter?.encrypt(jsonData, iv: _iv).base64;
      await _secureStorage.write(key: key, value: encryptedData);
    } else {
      await _secureStorage.write(key: key, value: jsonData);
    }
  }

  Future<List<dynamic>?> readList({required String key, bool isEncrypted = true}) async {
    final encryptedData = await _secureStorage.read(key: key);
    if (encryptedData != null) {
      if (isEncrypted) {
        final decryptedData = _encrypter?.decrypt64(encryptedData, iv: _iv);
        return json.decode(decryptedData!) as List<dynamic>;
      } else {
        return json.decode(encryptedData) as List<dynamic>;
      }
    }
    return null;
  }

  /// write and read JSON data
  Future<void> writeJson({required String key, required Map<String, dynamic> jsonMap, bool isEncrypted = true}) async {
    final jsonData = json.encode(jsonMap);
    if (isEncrypted) {
      final encryptedData = _encrypter?.encrypt(jsonData, iv: _iv).base64;
      await _secureStorage.write(key: key, value: encryptedData);
    } else {
      await _secureStorage.write(key: key, value: jsonData);
    }
  }

  Future<Map<String, dynamic>?> readJson({required String key, bool isEncrypted = true}) async {
    final encryptedData = await _secureStorage.read(key: key);
    if (encryptedData != null) {
      if (isEncrypted) {
        final decryptedData = _encrypter?.decrypt64(encryptedData, iv: _iv);
        return json.decode(decryptedData!) as Map<String, dynamic>;
      } else {
        return json.decode(encryptedData) as Map<String, dynamic>;
      }
    }
    return null;
  }


  Future<void> deleteData({required String key}) async {
    await _secureStorage.delete(key: key);
  }
}