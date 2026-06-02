import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class SpService {
  Future<void> write<T>(T value, StorageKey key);

  Future<void> writeRandom<T>(T value, String key);

  Future<T?> readRandom<T>(String key);

  Future<T?> read<T>(StorageKey key);

  T? readSync<T>(StorageKey key);

  Future<void> delete(StorageKey key);

  Future<List<String>?> readList(StorageKey key);

  Future<void> writeList(List<String> value, StorageKey key);

  Future<void> clearAll();
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
    switch (value) {
      case int _:
        await _sp.setInt(key.name, value as int);
      case String _:
        await _sp.setString(key.name, value as String);
      case bool _:
        await _sp.setBool(key.name, value as bool);
      case double _:
        await _sp.setDouble(key.name, value as double);
      default:
        throw ArgumentError('Unsupported type: ${value.runtimeType}');
    }
  }

  @override
  T? readSync<T>(StorageKey key) => _sp.get(key.name) as T?;

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
    switch (value) {
      case int _:
        await _sp.setInt(key, value as int);
      case String _:
        await _sp.setString(key, value as String);
      case bool _:
        await _sp.setBool(key, value as bool);
      case double _:
        await _sp.setDouble(key, value as double);
      default:
        throw ArgumentError('Unsupported type: ${value.runtimeType}');
    }
  }

  @override
  Future<T?> readRandom<T>(String key) async {
    return _sp.get(key) as T?;
  }

  @override
  Future<void> clearAll() async {
    await _sp.clear();
  }
}

enum StorageKey { register }
