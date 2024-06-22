import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daily_task_tracker/models/task.dart';
import 'package:daily_task_tracker/providers/task_provider.dart';
import 'package:daily_task_tracker/providers/category_provider.dart';

class TaskEditScreen extends StatefulWidget {
  final Task? task;

  const TaskEditScreen({super.key, this.task});

  @override

  // ignore: library_private_types_in_public_api
  _TaskEditScreenState createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends State<TaskEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late DateTime _dueDate;
  late String _category;

  @override
  void initState() {
    super.initState();
    _title = widget.task?.title ?? '';
    _description = widget.task?.description ?? '';
    _dueDate = widget.task?.dueDate ?? DateTime.now();
    _category = widget.task?.category ?? '未指定';
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final localizations = taskProvider.localizations;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null
            ? localizations.get('addTask')
            : localizations.get('editTask')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _title,
                decoration:
                    InputDecoration(labelText: localizations.get('title')),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return localizations.get('pleaseEnterTitle');
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(
                    labelText: localizations.get('description')),
                onSaved: (value) {
                  _description = value ?? '';
                },
              ),
              DropdownButtonFormField<String>(
                value: categoryProvider.categories.contains(_category)
                    ? _category
                    : localizations.get('unspecified'),
                decoration:
                    InputDecoration(labelText: localizations.get('category')),
                items: categoryProvider.categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category == '未指定'
                        ? localizations.get('unspecified')
                        : category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _category = newValue ?? '未指定';
                  });
                },
              ),
              Row(
                children: [
                  Text('${localizations.get('dueDate')}: '),
                  TextButton(
                    onPressed: _selectDate,
                    child: Text('${_dueDate.toLocal()}'.split(' ')[0]),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: _saveTask,
                child: Text(localizations.get('save')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _dueDate) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final task = Task(
        id: widget.task?.id,
        title: _title,
        description: _description,
        dueDate: _dueDate,
        isCompleted: widget.task?.isCompleted ?? false,
        category: _category,
      );

      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      if (widget.task == null) {
        taskProvider.addTask(task);
      } else {
        final index = taskProvider.getTaskIndex(widget.task!);
        taskProvider.updateTask(index, task);
      }
      Navigator.popUntil(context, (route) => route.isFirst);
    }
  }
}
