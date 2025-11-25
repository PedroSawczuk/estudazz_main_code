import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estudazz_main_code/services/db/tasks/tasksDB.dart';

enum AddTaskResult { success, emptyName, pastDueDate }

class TaskController {
  final TasksDB tasksDB;

  TaskController({required this.tasksDB});

  Future<AddTaskResult> addTask({
    required String uid,
    required String taskName,
    required DateTime dueDate,
  }) async {
    if (taskName.isEmpty) {
      return AddTaskResult.emptyName;
    }
    if (dueDate.isBefore(DateTime.now())) {
      return AddTaskResult.pastDueDate;
    }

    String dueDateString = dueDate.toIso8601String();

    await tasksDB.addTask(uid: uid, taskName: taskName, dueDate: dueDateString);
    return AddTaskResult.success;
  }

  Future<void> updateTask({
    required String taskId,
    required Map<String, dynamic> data,
  }) {
    return tasksDB.updateTask(taskId: taskId, data: data);
  }

  Future<bool> isTaskCompleted(String taskId) async {
    DocumentSnapshot taskSnapshot =
        await tasksDB.tasksCollection.doc(taskId).get();
    return taskSnapshot['task_completed'] ?? false;
  }
}