import 'dart:convert';
import 'package:daily_task_tracker/storage/storage.abstract.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:daily_task_tracker/models/task.dart';

class LocalStorage implements StorageAbstract {
  static const String _tasksKey = 'tasks';
  static const String _languageKey = 'language';
  static const String _categoriesKey = 'categories';

  @override
  Future<List<Task>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getStringList(_tasksKey) ?? [];
    return tasksJson.map((json) => Task.fromMap(jsonDecode(json))).toList();
  }

  @override
  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = tasks.map((task) => jsonEncode(task.toMap())).toList();
    await prefs.setStringList(_tasksKey, tasksJson);
  }

  @override
  Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey) ?? 'ja';
  }

  @override
  Future<void> setLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
  }

  @override
  Future<List<String>> getCategories() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_categoriesKey) ?? [];
  }

  @override
  Future<void> saveCategories(List<String> categories) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_categoriesKey, categories);
  }
}
