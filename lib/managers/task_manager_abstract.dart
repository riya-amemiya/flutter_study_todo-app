import 'package:daily_task_tracker/models/task_abstract.dart';
import 'package:daily_task_tracker/storage/storage_interface.dart';

abstract class TaskManagerAbstract {
  final StorageInterface storage;

  TaskManagerAbstract(this.storage);

  Future<void> addTask(TaskAbstract task);
  Future<void> updateTask(TaskAbstract task);
  Future<void> deleteTask(int taskId);
  Future<List<TaskAbstract>> getTasks();
  Future<void> toggleTaskCompletion(int taskId);
  Future<List<TaskAbstract>> getTasksDueToday();
}
