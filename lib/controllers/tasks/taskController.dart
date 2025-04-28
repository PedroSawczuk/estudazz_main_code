import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estudazz_main_code/services/db/tasks/tasksDB.dart';
import 'package:get/get.dart';

class TaskController {
  final TasksDB tasksDB;

  TaskController({required this.tasksDB});

  Future<void> addTask({
    required String uid,
    required String taskName,
    required DateTime dueDate,
  }) async {
    if (taskName.isEmpty) {
      Get.snackbar('Erro!', 'Nome da tarefa não pode ficar vazio');
    }
    if (dueDate.isBefore(DateTime.now())) {
      Get.snackbar('Erro!', 'A data não pode ser no passado');
    }

    String dueDateString = dueDate.toIso8601String();

    await tasksDB.addTask(uid: uid, taskName: taskName, dueDate: dueDateString);
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
