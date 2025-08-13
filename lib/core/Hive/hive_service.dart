import 'package:hive_flutter/hive_flutter.dart';
import 'dart:developer';

abstract class HiveService<T> {
  /// Box name - must be implemented by subclasses
  String get boxName;

  /// Get the box instance
  Box<T> get _box => Hive.box<T>(boxName);

  /// Check if box is open
  bool get isBoxOpen => Hive.isBoxOpen(boxName);

  /// Open box if not already open
  Future<Box<T>> openBox() async {
    if (isBoxOpen) {
      return _box;
    }
    return await Hive.openBox<T>(boxName);
  }

  /// Generic box operations
  Future<void> put(String key, T value) async {
    await _box.put(key, value);
  }

  Future<void> putAt(int index, T value) async {
    await _box.putAt(index, value);
  }

  Future<int> add(T value) async {
    return await _box.add(value);
  }

  T? get(String key) {
    return _box.get(key);
  }

  T? getAt(int index) {
    return _box.getAt(index);
  }

  Stream<List<T>> getAllStream() async* {
    // Yield initial data
    yield getAll();

    // Listen to box changes and yield updated data
    await for (final _ in _box.watch()) {
      yield getAll();
    }
  }

  List<T> getAll() {
    return _box.values.toList();
  }

  Future<void> delete(String key) async {
    await _box.delete(key);
  }

  Future<void> deleteAt(int index) async {
    await _box.deleteAt(index);
  }

  Future<void> clear() async {
    log('Clearing all data from ${boxName} Hive box');
    await _box.clear();
  }

  /// Get all keys
  Iterable<dynamic> getAllKeys() {
    return _box.keys;
  }

  /// Get all values
  Iterable<T> getAllValues() {
    return _box.values;
  }

  /// Check if key exists
  bool containsKey(String key) {
    return _box.containsKey(key);
  }

  /// Get length of box
  int get length => _box.length;

  /// Check if box is empty
  bool get isEmpty => _box.isEmpty;

  /// Check if box is not empty
  bool get isNotEmpty => _box.isNotEmpty;

  /// Close box
  Future<void> closeBox() async {
    if (isBoxOpen) {
      await _box.close();
    }
  }

  /// Delete box from disk
  Future<void> deleteBox() async {
    if (isBoxOpen) {
      await _box.close();
    }
    await Hive.deleteBoxFromDisk(boxName);
  }

  /// Find first item that matches condition
  T? findFirst(bool Function(T) test) {
    try {
      return _box.values.firstWhere(test);
    } catch (e) {
      return null;
    }
  }

  /// Find all items that match condition
  List<T> findWhere(bool Function(T) test) {
    return _box.values.where(test).toList(growable: false);
  }

  /// Update item at specific index
  Future<void> updateAt(int index, T Function(T) updater) async {
    final current = getAt(index);
    if (current != null) {
      final updated = updater(current);
      await putAt(index, updated);
    }
  }

  /// Update all items that match condition
  Future<void> updateWhere(bool Function(T) test, T Function(T) updater) async {
    final entries = _box.toMap();
    for (final entry in entries.entries) {
      if (test(entry.value)) {
        final updated = updater(entry.value);
        await _box.put(entry.key, updated);
      }
    }
  }

  /// Get items with pagination
  List<T> getPaginated({int page = 0, int pageSize = 10}) {
    final startIndex = page * pageSize;

    if (startIndex >= length) return [];

    return _box.values.skip(startIndex).take(pageSize).toList(growable: false);
  }

  /// Get statistics about the box
  Map<String, dynamic> getBoxStats() {
    return {
      'boxName': boxName,
      'length': length,
      'isEmpty': isEmpty,
      'isOpen': isBoxOpen,
      'sizeInBytes': _box.lazy ? 'N/A (Lazy box)' : 'N/A',
    };
  }
}
