import 'package:estudazz_main_code/components/custom/customSnackBar.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/constants/constSizedBox.dart';
import 'package:estudazz_main_code/controllers/tasks/taskController.dart';
import 'package:estudazz_main_code/services/db/tasks/tasksDB.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                Text("A tarefa '$taskName' já foi marcada como concluída."),
                ConstSizedBox.h10,
                Text("Deseja desmarcá-la? como concluída?"),
              ],
            ),
            actions: [
              TextButton(
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
                    CustomSnackBar.show(
                      title: 'Tarefa Desmarcada',
                      message: 'A tarefa "$taskName" foi desmarcada com sucesso.',
                      backgroundColor: ConstColors.greenColor,
                    );
                  } catch (e) {
                    CustomSnackBar.show(
                      title: 'Erro!',
                      message: 'Erro ao desmarcar tarefa: $e',
                      backgroundColor: ConstColors.redColor,
                    );
                  }
                  Get.back();
                },
                child: Text('Desmarcar'),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("Cancelar"),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: ConstColors.redColor),
                    onPressed: () async {
                      try {
                        await _taskController.tasksDB.deleteTask(
                          taskId,
                        );
                        CustomSnackBar.show(
                          title: 'Tarefa Excluída',
                          message: 'A tarefa "$taskName" foi excluída com sucesso.',
                          backgroundColor: ConstColors.greenColor,
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Erro ao excluir tarefa: $e'),
                            backgroundColor: ConstColors.redColor,
                          ),
                        );
                      }
                      Get.back();
                    },
                  ),
                  TextButton(
                    onPressed: () async {
                      try {
                        await _taskController.tasksDB.updateTask(
                          taskId: taskId,
                          data: {
                            'task_completed': true,
                            'task_completed_at':
                                DateTime.now().toIso8601String(),
                          },
                        );
                        CustomSnackBar.show(
                          title: 'Tarefa Concluída',
                          message: 'A tarefa foi marcada como concluída.',
                          backgroundColor: ConstColors.greenColor,
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
                      Get.back();
                    },
                    child: Text("Confirmar"),
                  ),
                ],
              ),
            ],
          );
        },
      );
    }
  }
}
