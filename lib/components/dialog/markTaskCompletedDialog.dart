import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/services/db/tasks/tasksDB.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:estudazz_main_code/controllers/tasks/taskController.dart';

class MarkTaskCompletedDialog {
  final TaskController _taskController = TaskController(tasksDB: TasksDB());

  Future<void> showMarkTaskCompletedDialog({
    required BuildContext context,
    required String taskId,
    required String taskName,
  }) async {
    bool isTaskCompleted = await _taskController.isTaskCompleted(taskId);
    if (isTaskCompleted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Tarefa Concluída",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("A tarefa ${taskName} já foi marcada como concluída."),
                SizedBox(height: 10),
                Text("Deseja desmarcá-la? como concluída?"),
              ],
            ),
            actions: [
              TextButton(
                // Estiliza o botão "Desmarcar"
                style: TextButton.styleFrom(
                  backgroundColor: ConstColors.redColor,
                  foregroundColor: ConstColors.whiteColor,
                ),
                onPressed: () async {
                  try {
                    await _taskController.tasksDB.updateTask(
                      taskId: taskId,
                      data: {
                        'task_completed': false,
                        'task_completed_at': null,
                      },
                    );
                    Get.snackbar(
                      'Tarefa Desmarcada',
                      'A tarefa foi desmarcada como concluída.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: ConstColors.yellowColor,
                      colorText: ConstColors.whiteColor,
                      duration: Duration(seconds: 2),
                    );
                  } catch (e) {
                    Get.snackbar(
                      'Erro',
                      'Ocorreu um erro ao desmarcar a tarefa: $e',
                    );
                  }
                  Navigator.of(context).pop();
                },
                child: Text('Desmarcar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Marcar Tarefa como Concluída",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text(
              "Você tem certeza que deseja marcar a tarefa ${taskName} como concluída?",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancelar"),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    await _taskController.tasksDB.updateTask(
                      taskId: taskId,
                      data: {
                        'task_completed': true,
                        'task_completed_at': DateTime.now().toIso8601String(),
                      },
                    );
                    Get.snackbar(
                      'Tarefa Concluída',
                      'A tarefa foi marcada como concluída.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: ConstColors.greenColor,
                      colorText: ConstColors.whiteColor,
                      duration: Duration(seconds: 2),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Erro ao marcar tarefa como concluída: $e',
                        ),
                        backgroundColor: ConstColors.redColor,
                      ),
                    );
                  }
                  Navigator.of(context).pop();
                },
                child: Text("Confirmar"),
              ),
            ],
          );
        },
      );
    }
  }
}
