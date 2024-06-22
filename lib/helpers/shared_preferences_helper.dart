import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:daily_task_tracker/models/task.dart';

class SharedPreferencesHelper {
  static const String _tasksKey = 'tasks';
  static const String _languageKey = 'language';

  static Future<List<Task>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getStringList(_tasksKey) ?? [];
    return tasksJson.map((json) => Task.fromMap(jsonDecode(json))).toList();
  }

  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = tasks.map((task) => jsonEncode(task.toMap())).toList();
    await prefs.setStringList(_tasksKey, tasksJson);
  }

  static Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey) ?? 'ja';
  }

  static Future<void> setLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
  }

  static const String _categoriesKey = 'categories';

  static Future<List<String>> getCategories() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_categoriesKey) ?? [];
  }

  static Future<void> saveCategories(List<String> categories) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_categoriesKey, categories);
  }
}
