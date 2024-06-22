// lib/models/task.dart

class Task {
  final int? id;
  final String title;
  final String description;
  final DateTime dueDate;
  bool isCompleted;
  late final String category;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    this.isCompleted = false,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'isCompleted': isCompleted ? 1 : 0,
      'category': category,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dueDate: DateTime.parse(map['dueDate']),
      isCompleted: map['isCompleted'] == 1,
      category: map['category'],
    );
  }
}
