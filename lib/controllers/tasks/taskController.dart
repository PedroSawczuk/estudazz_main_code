import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estudazz_main_code/services/db/tasks/tasksDB.dart';
import 'package:estudazz_main_code/components/custom/customSnackBar.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'dart:async';

enum AddTaskResult { success, emptyName, pastDueDate, error }

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

    String dueDateString = dueDate.toIso8601String();

    try {
      await tasksDB.addTask(uid: uid, taskName: taskName, dueDate: dueDateString);
      return AddTaskResult.success;
    } catch (e) {
      CustomSnackBar.show(
        title: 'Servidor Ocupado',
        message: 'A solicitação demorou muito. Verifique sua rede e tente novamente.',
        backgroundColor: ConstColors.redColor,
      );
      return AddTaskResult.error;
    }
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