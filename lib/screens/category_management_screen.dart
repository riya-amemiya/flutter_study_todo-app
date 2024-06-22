import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daily_task_tracker/providers/category_provider.dart';
import 'package:daily_task_tracker/providers/task_provider.dart';
import 'package:daily_task_tracker/localization/app_localizations.dart';

class CategoryManagementScreen extends StatelessWidget {
  const CategoryManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final localizations = taskProvider.localizations;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.get('manageCategories')),
      ),
      body: ListView.builder(
        itemCount: categoryProvider.categories.length,
        itemBuilder: (context, index) {
          final category = categoryProvider.categories[index];
          return ListTile(
            title: Text(category),
            trailing: category != '未指定'
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _editCategory(
                            context,
                            categoryProvider,
                            taskProvider,
                            localizations,
                            category),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteCategory(
                            context,
                            categoryProvider,
                            taskProvider,
                            localizations,
                            category),
                      ),
                    ],
                  )
                : null,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addCategory(context, categoryProvider, localizations),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addCategory(BuildContext context, CategoryProvider categoryProvider,
      AppLocalizations localizations) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newCategory = '';
        return AlertDialog(
          title: Text(localizations.get('addNewCategory')),
          content: TextField(
            onChanged: (value) {
              newCategory = value;
            },
            decoration: InputDecoration(
                hintText: localizations.get('enterCategoryName')),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(localizations.get('cancel')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(localizations.get('add')),
              onPressed: () {
                if (newCategory.isNotEmpty) {
                  categoryProvider.addCategory(newCategory);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _editCategory(
      BuildContext context,
      CategoryProvider categoryProvider,
      TaskProvider taskProvider,
      AppLocalizations localizations,
      String oldCategory) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newCategory = oldCategory;
        return AlertDialog(
          title: Text(localizations.get('editCategory')),
          content: TextField(
            onChanged: (value) {
              newCategory = value;
            },
            decoration: InputDecoration(
                hintText: localizations.get('enterNewCategoryName')),
            controller: TextEditingController(text: oldCategory),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(localizations.get('cancel')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(localizations.get('save')),
              onPressed: () {
                if (newCategory.isNotEmpty && newCategory != oldCategory) {
                  categoryProvider.editCategory(oldCategory, newCategory);
                  taskProvider.updateTaskCategory(oldCategory, newCategory);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteCategory(
      BuildContext context,
      CategoryProvider categoryProvider,
      TaskProvider taskProvider,
      AppLocalizations localizations,
      String category) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(localizations.get('deleteCategory')),
          content: Text(localizations.get('areYouSureDeleteCategory')),
          actions: <Widget>[
            TextButton(
              child: Text(localizations.get('cancel')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(localizations.get('delete')),
              onPressed: () {
                categoryProvider.removeCategory(category);
                taskProvider.updateTaskCategory(category, '未指定');
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
