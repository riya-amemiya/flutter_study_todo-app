import 'package:shared_preferences/shared_preferences.dart';
import 'storage_interface.dart';

class LocalStorage implements StorageInterface {
  @override
  Future<void> saveData(String key, dynamic data) async {
    final prefs = await SharedPreferences.getInstance();
    if (data is int) {
      await prefs.setInt(key, data);
    } else if (data is String) {
      await prefs.setString(key, data);
    } else if (data is bool) {
      await prefs.setBool(key, data);
    } else if (data is List<String>) {
      await prefs.setStringList(key, data);
    }
  }

  @override
  Future<dynamic> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  @override
  Future<void> removeData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
