import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estudazz_main_code/components/custom/customSnackBar.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/services/db/tasks/tasksDB.dart';

class TaskController {
  final TasksDB tasksDB;

  TaskController({required this.tasksDB});

  Future<void> addTask({
    required String uid,
    required String taskName,
    required DateTime dueDate,
  }) async {
    if (taskName.isEmpty) {
      CustomSnackBar.show(
        title: 'Erro!',
        message: 'O nome da tarefa não pode ser vazio', 
        backgroundColor: ConstColors.redColor,
      );
    }
    if (dueDate.isBefore(DateTime.now())) {
      CustomSnackBar.show(
        title: 'Erro!',
        message: 'A data de vencimento não pode ser no passado',
        backgroundColor: ConstColors.redColor,
      );
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
