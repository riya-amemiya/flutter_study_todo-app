import 'task_abstract.dart';

class RegularTask extends TaskAbstract {
  RegularTask({
    super.id,
    required super.title,
    required super.description,
    required super.dueDate,
    super.isCompleted,
    required super.category,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'isCompleted': isCompleted,
      'category': category,
      'type': 'regular',
    };
  }

  factory RegularTask.fromMap(Map<String, dynamic> map) {
    return RegularTask(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dueDate: DateTime.parse(map['dueDate']),
      isCompleted: map['isCompleted'],
      category: map['category'],
    );
  }

  @override
  bool shouldExecute(DateTime currentDate) {
    return currentDate.isBefore(dueDate) ||
        currentDate.isAtSameMomentAs(dueDate);
  }

  @override
  TaskAbstract clone() {
    return RegularTask(
      id: id,
      title: title,
      description: description,
      dueDate: dueDate,
      isCompleted: isCompleted,
      category: category,
    );
  }
}
