import 'package:daily_task_tracker/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'category_management_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final localizations = taskProvider.localizations;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.get('settings')),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(localizations.get('language')),
            trailing: DropdownButton<String>(
              value: taskProvider.languageCode,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  taskProvider.setLanguage(newValue);
                }
              },
              items: const [
                DropdownMenuItem(value: 'ja', child: Text('日本語')),
                DropdownMenuItem(value: 'en', child: Text('English')),
              ],
            ),
          ),
          ListTile(
            title: Text(localizations.get('manageCategories')),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CategoryManagementScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
