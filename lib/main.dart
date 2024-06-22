// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/task_provider.dart';
import 'providers/category_provider.dart';
import 'screens/task_list_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProxyProvider<CategoryProvider, TaskProvider>(
          create: (context) => TaskProvider(context.read<CategoryProvider>()),
          update: (context, categoryProvider, previousTaskProvider) =>
              TaskProvider(categoryProvider)..updateFrom(previousTaskProvider),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Task Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const TaskListScreen(),
    );
  }
}
