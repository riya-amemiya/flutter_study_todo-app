import 'package:daily_task_tracker/models/task.dart';

abstract class StorageAbstract {
  Future<List<Task>> getTasks();
  Future<void> saveTasks(List<Task> tasks);
  Future<String> getLanguage();
  Future<void> setLanguage(String languageCode);
  Future<List<String>> getCategories();
  Future<void> saveCategories(List<String> categories);
}
