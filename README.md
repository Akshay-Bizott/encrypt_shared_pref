## encrypt_shared_pref
Simple to use yet powerful package to encrypt shared preferences in android iOS and web.

## Features

- Simple to use yet powerful package to encrypt shared preferences in android iOS and web.
- You have an option to bypass encryption just by passing a bool.
- Supports String, int, bool, double, map and List<String>.
- Uses advanced AES-CBC-128 algorithm for encryption.
- Encrypts both key and value.

## Getting started

1. add dependency in your project pubspec.yaml file encrypted_shared_pref: [version]
2. add import import 'package:encrypted_shared_pref/encrypted_shared_pref.dart';

## Usage
1. string data type to save securely encrypt storage.
```dart
    final SecureStorage secureStorage = SecureStorage();
    secureStorage.writeString("Key", "This is local storage", isEncrypted : true);
```
1. string data type to get securely encrypt storage.
```dart
    final SecureStorage secureStorage = SecureStorage();
    secureStorage.readString("Key", isEncrypted : true);
```

#### Usage
1. Save :
```
    final SecureStorage secureStorage = SecureStorage();
    await secureStorage.writeString("encryptedString", "This is first string",isEncrypted: true);
    await secureStorage.writeInt("key", 50, isEncrypted: true);
    await secureStorage.writeJson("keyMap", {"Hey":true}, isEncrypted: true);
    await secureStorage.writeBool("keyBool", true,isEncrypted:  true);
    await secureStorage.writeStringList("keyList", ["A","K"], isEncrypted: true);
```
First parameter is the key and second parameter is value and third parameter is whether you want to encrypt this key/value or not.

2. Fetch :
```
    final SecureStorage secureStorage = SecureStorage();
    await secureStorage.readString("encryptedString", "This is first string",isEncrypted: true);
    await secureStorage.readInt("key", 50, isEncrypted: true);
    await secureStorage.readJson("keyMap", {"Hey":true}, isEncrypted: true);
    await secureStorage.readBool("keyBool", true,isEncrypted:  true);
    await secureStorage.readStringList("keyList", ["A","K"], isEncrypted: true);
```
First parameter is the key and second parameter is whether you want to encrypt this key/value or not.
