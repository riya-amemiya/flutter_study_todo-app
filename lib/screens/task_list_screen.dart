import 'package:daily_task_tracker/localization/app_localizations.dart';
import 'package:daily_task_tracker/providers/task_provider.dart';
import 'package:daily_task_tracker/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_edit_screen.dart';
import 'task_detail_screen.dart';
import 'settings_screen.dart'; // 新しい設定画面

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<TaskProvider, CategoryProvider>(
      builder: (context, taskProvider, categoryProvider, child) {
        if (!taskProvider.isInitialized) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final localizations = taskProvider.localizations;

        return Scaffold(
          appBar: AppBar(
            title: Text(localizations.get('appTitle')),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsScreen()),
                  );
                },
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: localizations.get('searchTasks'),
                    prefixIcon: const Icon(Icons.search),
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    taskProvider.setSearchQuery(value);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButton<String?>(
                        isExpanded: true,
                        value: taskProvider.selectedCategory,
                        hint: Text(localizations.get('filterByCategory')),
                        onChanged: (String? newValue) {
                          taskProvider.setSelectedCategory(newValue);
                        },
                        items: [
                          DropdownMenuItem<String?>(
                            value: null,
                            child: Text(localizations.get('allCategories')),
                          ),
                          ...categoryProvider.categories
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value == '未指定'
                                  ? localizations.get('unspecified')
                                  : value),
                            );
                          }),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    DropdownButton<SortOption>(
                      value: taskProvider.currentSortOption,
                      onChanged: (SortOption? newValue) {
                        if (newValue != null) {
                          taskProvider.setSortOption(newValue);
                        }
                      },
                      items: SortOption.values
                          .map<DropdownMenuItem<SortOption>>(
                              (SortOption value) {
                        return DropdownMenuItem<SortOption>(
                          value: value,
                          child: Text(_getSortOptionText(value, localizations)),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: taskProvider.tasks.length,
                  itemBuilder: (context, index) {
                    final task = taskProvider.tasks[index];
                    return Dismissible(
                      key: Key(task.id.toString()),
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) async {
                        await taskProvider
                            .deleteTask(taskProvider.getTaskIndex(task));
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              '${task.title} ${localizations.get("delete")}'),
                          action: SnackBarAction(
                            label: localizations.get("undo"),
                            onPressed: () {
                              taskProvider.addTask(task);
                            },
                          ),
                        ));
                      },
                      child: ListTile(
                        title: Text(
                          task.title,
                          style: TextStyle(
                            decoration: task.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        subtitle: Text(
                            '${localizations.get("dueDate")}: ${task.dueDate.toLocal().toString().split(' ')[0]} - ${localizations.get("category")}: ${task.category == '未指定' ? localizations.get("unspecified") : task.category}'),
                        trailing: Checkbox(
                          value: task.isCompleted,
                          onChanged: (bool? value) {
                            taskProvider.toggleTaskCompletion(
                                taskProvider.getTaskIndex(task));
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TaskDetailScreen(task: task),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TaskEditScreen()),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  String _getSortOptionText(SortOption option, AppLocalizations localizations) {
    switch (option) {
      case SortOption.dueDate:
        return localizations.get('dueDate');
      case SortOption.title:
        return localizations.get('title');
      case SortOption.category:
        return localizations.get('category');
    }
  }
}
