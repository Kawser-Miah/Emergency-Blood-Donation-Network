import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class SpService {
  Future<void> write<T>(T value, StorageKey key);

  Future<void> writeRandom<T>(T value, String key);

  Future<T?> readRandom<T>(String key);

  Future<T?> read<T>(StorageKey key);

  Future<void> delete(StorageKey key);

  Future<List<String>?> readList(StorageKey key);

  Future<void> writeList(List<String> value, StorageKey key);
}

@LazySingleton(as: SpService)
class SpServiceImpl implements SpService {
  final SharedPreferences _sp;

  SpServiceImpl(this._sp);

  @override
  Future<void> delete(StorageKey key) async {
    await _sp.remove(key.name);
  }

  @override
  Future<T?> read<T>(StorageKey key) async {
    final value = _sp.get(key.name) as T?;
    return Future.value(value);
  }

  @override
  Future<void> write<T>(T value, StorageKey key) async {
    switch (value.runtimeType) {
      case int:
        await _sp.setInt(key.name, value as int);
        break;
      case String:
        await _sp.setString(key.name, value as String);
        break;
      case bool:
        await _sp.setBool(key.name, value as bool);
        break;
      case double:
        await _sp.setDouble(key.name, value as double);
        break;
      // ToDo: write code for list and objects
      default:
        throw ArgumentError('Unsupported type: ${value.runtimeType}');
    }
  }

  @override
  Future<List<String>?> readList(StorageKey key) async {
    final List<String>? list = _sp.getStringList(key.toString());
    if (list == null) {
      return null;
    }
    return list;
  }

  @override
  Future<void> writeList(List<String> value, StorageKey key) async {
    await _sp.setStringList(key.toString(), value);
  }

  @override
  Future<void> writeRandom<T>(T value, String key) async {
    // TODO: implement writeRandom
    await _sp.setString(key, value.toString());
  }

  @override
  Future<T?> readRandom<T>(String key) async {
    // Assume _sp is an instance of SharedPreferences
    final value = _sp.getString(key);
    // Attempt to cast the value to T
    return value as T?;
  }
}

enum StorageKey { register }
