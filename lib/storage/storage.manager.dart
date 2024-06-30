import 'package:daily_task_tracker/models/task.dart';
import 'package:daily_task_tracker/storage/local_storage.dart';
import 'package:daily_task_tracker/storage/storage.abstract.dart';

enum StorageType { local }

class StorageManager implements StorageAbstract {
  late final StorageAbstract _storage;

  StorageManager({StorageType storageType = StorageType.local}) {
    _init(storageType);
  }

  Future<void> _init(StorageType storageType) async {
    switch (storageType) {
      case StorageType.local:
        _storage = LocalStorage();
        break;
    }
  }

  @override
  Future<List<Task>> getTasks() async {
    return await _storage.getTasks();
  }

  @override
  Future<void> saveTasks(List<Task> tasks) async {
    await _storage.saveTasks(tasks);
  }

  @override
  Future<String> getLanguage() async {
    return await _storage.getLanguage();
  }

  @override
  Future<void> setLanguage(String languageCode) async {
    await _storage.setLanguage(languageCode);
  }

  @override
  Future<List<String>> getCategories() async {
    return await _storage.getCategories();
  }

  @override
  Future<void> saveCategories(List<String> categories) async {
    await _storage.saveCategories(categories);
  }
}
