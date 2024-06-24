abstract class TaskAbstract {
  int? id;
  String title;
  String description;
  DateTime dueDate;
  bool isCompleted;
  String category;

  TaskAbstract({
    this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    this.isCompleted = false,
    required this.category,
  });

  Map<String, dynamic> toMap();

  factory TaskAbstract.fromMap(Map<String, dynamic> map) {
    throw UnimplementedError(
        'TaskAbstract.fromMap() has not been implemented.');
  }
  bool shouldExecute(DateTime currentDate);
  TaskAbstract clone();
}
