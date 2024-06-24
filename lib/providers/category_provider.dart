import 'package:flutter/foundation.dart';
import 'package:daily_task_tracker/storage/local_storage.dart';

class CategoryProvider with ChangeNotifier {
  final LocalStorage _storage = LocalStorage();
  List<String> _categories = [];
  List<String> get categories => ['未指定', ..._categories];

  CategoryProvider() {
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    _categories = await _storage.getCategories();
    notifyListeners();
  }

  Future<void> addCategory(String category) async {
    if (!_categories.contains(category)) {
      _categories.add(category);
      await _saveCategories();
      notifyListeners();
    }
  }

  Future<void> editCategory(String oldCategory, String newCategory) async {
    if (oldCategory != '未指定' &&
        _categories.contains(oldCategory) &&
        !_categories.contains(newCategory)) {
      int index = _categories.indexOf(oldCategory);
      _categories[index] = newCategory;
      await _saveCategories();
      notifyListeners();
    }
  }

  Future<void> removeCategory(String category) async {
    if (category != '未指定' && _categories.contains(category)) {
      _categories.remove(category);
      await _saveCategories();
      notifyListeners();
    }
  }

  Future<void> _saveCategories() async {
    await _storage.saveCategories(_categories);
  }
}
