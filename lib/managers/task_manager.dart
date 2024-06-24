// lib/managers/task_manager.dart

import 'task_manager_abstract.dart';
import 'package:daily_task_tracker/models/task_abstract.dart';
import 'package:daily_task_tracker/models/regular_task.dart';
import 'package:daily_task_tracker/models/recurring_task.dart';
import 'package:daily_task_tracker/storage/storage_interface.dart';

class TaskManager implements TaskManagerAbstract {
  @override
  final StorageInterface storage;

  TaskManager(this.storage);

  @override
  Future<void> addTask(TaskAbstract task) async {
    List<Map<String, dynamic>> tasks = await _getTasksFromStorage();
    tasks.add(task.toMap());
    await storage.saveData('tasks', tasks);
  }

  @override
  Future<void> updateTask(TaskAbstract task) async {
    List<Map<String, dynamic>> tasks = await _getTasksFromStorage();
    int index = tasks.indexWhere((t) => t['id'] == task.id);
    if (index != -1) {
      tasks[index] = task.toMap();
      await storage.saveData('tasks', tasks);
    }
  }

  @override
  Future<void> deleteTask(int taskId) async {
    List<Map<String, dynamic>> tasks = await _getTasksFromStorage();
    tasks.removeWhere((task) => task['id'] == taskId);
    await storage.saveData('tasks', tasks);
  }

  @override
  Future<List<TaskAbstract>> getTasks() async {
    List<Map<String, dynamic>> tasks = await _getTasksFromStorage();
    return tasks.map((task) => _createTaskFromMap(task)).toList();
  }

  @override
  Future<void> toggleTaskCompletion(int taskId) async {
    List<Map<String, dynamic>> tasks = await _getTasksFromStorage();
    int index = tasks.indexWhere((task) => task['id'] == taskId);
    if (index != -1) {
      tasks[index]['isCompleted'] = !tasks[index]['isCompleted'];
      await storage.saveData('tasks', tasks);
    }
  }

  @override
  Future<List<TaskAbstract>> getTasksDueToday() async {
    List<TaskAbstract> allTasks = await getTasks();
    DateTime today = DateTime.now();
    return allTasks.where((task) => task.shouldExecute(today)).toList();
  }

  Future<List<Map<String, dynamic>>> _getTasksFromStorage() async {
    List<dynamic> tasksData = await storage.getData('tasks') ?? [];
    return tasksData.cast<Map<String, dynamic>>();
  }

  TaskAbstract _createTaskFromMap(Map<String, dynamic> map) {
    switch (map['type']) {
      case 'regular':
        return RegularTask.fromMap(map);
      case 'recurring':
        return RecurringTask.fromMap(map);
      default:
        throw Exception('Unknown task type');
    }
  }
}
