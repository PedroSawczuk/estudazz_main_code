class TaskModel {
  final String id;
  final String taskName;
  final DateTime dueDate;
  final bool taskCompleted;

  TaskModel({
    required this.id,
    required this.taskName,
    required this.dueDate,
    required this.taskCompleted,
  });

  factory TaskModel.fromDocument(Map<String, dynamic> doc, String docId) {
    return TaskModel(
      id: docId,
      taskName: doc['task_name'] ?? '',
      dueDate: DateTime.parse(doc['due_date']),
      taskCompleted: doc['task_completed'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'task_name': taskName,
      'due_date': dueDate.toIso8601String(),
      'task_completed': taskCompleted,
    };
  }
}
