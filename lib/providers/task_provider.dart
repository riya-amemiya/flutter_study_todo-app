import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:daily_task_tracker/models/task.dart';
import 'package:daily_task_tracker/helpers/shared_preferences_helper.dart';
import 'package:daily_task_tracker/localization/app_localizations.dart';
import 'category_provider.dart';

enum SortOption { dueDate, title, category }

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  SortOption _currentSortOption = SortOption.dueDate;
  String _searchQuery = '';
  String? _selectedCategory;
  final Map<int, Timer> _deleteTimers = {};
  String _languageCode = 'ja';
  late AppLocalizations _localizations = AppLocalizations(_languageCode);
  bool _isInitialized = false;
  final CategoryProvider categoryProvider;

  TaskProvider(this.categoryProvider) {
    _init();
  }

  Future<void> _init() async {
    await _loadLanguage();
    await loadTasks();
    _isInitialized = true;
    notifyListeners();
  }

  AppLocalizations get localizations => _localizations;
  String get languageCode => _languageCode;
  bool get isInitialized => _isInitialized;

  List<Task> get tasks {
    List<Task> filteredTasks = _searchQuery.isEmpty
        ? _tasks
        : _tasks
            .where((task) =>
                task.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                task.description
                    .toLowerCase()
                    .contains(_searchQuery.toLowerCase()))
            .toList();

    if (_selectedCategory != null) {
      filteredTasks = filteredTasks
          .where((task) => task.category == _selectedCategory)
          .toList();
    }

    _sortTasks(filteredTasks);
    return filteredTasks;
  }

  SortOption get currentSortOption => _currentSortOption;
  String? get selectedCategory => _selectedCategory;

  Future<void> loadTasks() async {
    _tasks = await SharedPreferencesHelper.getTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    _tasks.add(task);
    await _saveTasks();
    notifyListeners();
  }

  Future<void> toggleTaskCompletion(int index) async {
    _tasks[index].isCompleted = !_tasks[index].isCompleted;
    await _saveTasks();
    notifyListeners();

    if (_tasks[index].isCompleted) {
      _scheduleTaskDeletion(index);
    } else {
      _cancelTaskDeletion(index);
    }
  }

  Future<void> updateTask(int index, Task newTask) async {
    _tasks[index] = newTask;
    await _saveTasks();
    notifyListeners();
  }

  Future<void> deleteTask(int index) async {
    _cancelTaskDeletion(index);
    _tasks.removeAt(index);
    await _saveTasks();
    notifyListeners();
  }

  void setSortOption(SortOption option) {
    _currentSortOption = option;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSelectedCategory(String? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  int getTaskIndex(Task task) {
    return _tasks.indexOf(task);
  }

  void _sortTasks(List<Task> taskList) {
    switch (_currentSortOption) {
      case SortOption.dueDate:
        taskList.sort((a, b) => a.dueDate.compareTo(b.dueDate));
        break;
      case SortOption.title:
        taskList.sort((a, b) => a.title.compareTo(b.title));
        break;
      case SortOption.category:
        taskList.sort((a, b) => a.category.compareTo(b.category));
        break;
    }
  }

  Future<void> _saveTasks() async {
    await SharedPreferencesHelper.saveTasks(_tasks);
  }

  void _scheduleTaskDeletion(int index) {
    _deleteTimers[index] = Timer(const Duration(seconds: 3), () {
      deleteTask(index);
    });
  }

  void _cancelTaskDeletion(int index) {
    _deleteTimers[index]?.cancel();
    _deleteTimers.remove(index);
  }

  Future<void> _loadLanguage() async {
    _languageCode = await SharedPreferencesHelper.getLanguage();
    _localizations = AppLocalizations(_languageCode);
  }

  Future<void> setLanguage(String languageCode) async {
    await SharedPreferencesHelper.setLanguage(languageCode);
    _languageCode = languageCode;
    _localizations = AppLocalizations(_languageCode);
    notifyListeners();
  }

  Future<void> updateTaskCategory(
      String oldCategory, String newCategory) async {
    for (var task in _tasks) {
      if (task.category == oldCategory) {
        task.category = newCategory;
      }
    }
    await _saveTasks();
    notifyListeners();
  }

  void updateFrom(TaskProvider? oldProvider) {
    if (oldProvider != null) {
      _tasks = oldProvider._tasks;
      _currentSortOption = oldProvider._currentSortOption;
      _searchQuery = oldProvider._searchQuery;
      _selectedCategory = oldProvider._selectedCategory;
      _deleteTimers.addAll(oldProvider._deleteTimers);
      _localizations = oldProvider._localizations;
      _languageCode = oldProvider._languageCode;
      _isInitialized = oldProvider._isInitialized;
    }
  }

  @override
  void dispose() {
    for (var timer in _deleteTimers.values) {
      timer.cancel();
    }
    super.dispose();
  }
}
