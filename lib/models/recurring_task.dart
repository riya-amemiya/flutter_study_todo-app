import 'task_abstract.dart';

enum RecurrenceType { daily, weekly, monthly, yearly }

class RecurringTask extends TaskAbstract {
  RecurrenceType recurrenceType;
  int recurrenceInterval;

  RecurringTask({
    super.id,
    required super.title,
    required super.description,
    required super.dueDate,
    super.isCompleted,
    required super.category,
    required this.recurrenceType,
    this.recurrenceInterval = 1,
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
      'type': 'recurring',
      'recurrenceType': recurrenceType.toString(),
      'recurrenceInterval': recurrenceInterval,
    };
  }

  factory RecurringTask.fromMap(Map<String, dynamic> map) {
    return RecurringTask(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dueDate: DateTime.parse(map['dueDate']),
      isCompleted: map['isCompleted'],
      category: map['category'],
      recurrenceType: RecurrenceType.values
          .firstWhere((e) => e.toString() == map['recurrenceType']),
      recurrenceInterval: map['recurrenceInterval'],
    );
  }

  @override
  bool shouldExecute(DateTime currentDate) {
    if (currentDate.isBefore(dueDate)) return false;

    final difference = currentDate.difference(dueDate);
    switch (recurrenceType) {
      case RecurrenceType.daily:
        return difference.inDays % recurrenceInterval == 0;
      case RecurrenceType.weekly:
        return difference.inDays % (7 * recurrenceInterval) == 0;
      case RecurrenceType.monthly:
        return (currentDate.month -
                    dueDate.month +
                    (currentDate.year - dueDate.year) * 12) %
                recurrenceInterval ==
            0;
      case RecurrenceType.yearly:
        return (currentDate.year - dueDate.year) % recurrenceInterval == 0;
    }
  }

  @override
  TaskAbstract clone() {
    return RecurringTask(
      id: id,
      title: title,
      description: description,
      dueDate: dueDate,
      isCompleted: isCompleted,
      category: category,
      recurrenceType: recurrenceType,
      recurrenceInterval: recurrenceInterval,
    );
  }
}
