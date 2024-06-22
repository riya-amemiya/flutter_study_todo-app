import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daily_task_tracker/models/task.dart';
import 'package:daily_task_tracker/providers/task_provider.dart';
import 'task_edit_screen.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final localizations = taskProvider.localizations;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.get('taskDetails')),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _editTask(context),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteTask(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${localizations.get('title')}: ${task.title}',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('${localizations.get('description')}: ${task.description}'),
            const SizedBox(height: 8),
            Text(
                '${localizations.get('dueDate')}: ${task.dueDate.toLocal().toString().split(' ')[0]}'),
            const SizedBox(height: 8),
            Text('${localizations.get('category')}: ${task.category}'),
            const SizedBox(height: 8),
            Text(
                '${localizations.get('status')}: ${task.isCompleted ? localizations.get('completed') : localizations.get('pending')}'),
          ],
        ),
      ),
    );
  }

  void _editTask(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskEditScreen(task: task),
      ),
    );
  }

  void _deleteTask(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final localizations = taskProvider.localizations;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(localizations.get('deleteTask')),
        content: Text(localizations.get('areYouSureDeleteTask')),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(localizations.get('cancel')),
          ),
          TextButton(
            onPressed: () {
              taskProvider.deleteTask(taskProvider.getTaskIndex(task));
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
            },
            child: Text(localizations.get('delete')),
          ),
        ],
      ),
    );
  }
}
