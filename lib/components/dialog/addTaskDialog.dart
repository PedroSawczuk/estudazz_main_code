import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:estudazz_main_code/controllers/tasks/taskController.dart';

class AddTaskDialog {
  final TextEditingController _taskNameController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> showAddTaskDialog({
    required BuildContext context,
    required TaskController taskController,
    required Future<String?> Function() getUserUid,
  }) async {
    DateTime? tempSelectedDate = _selectedDate;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            String formatDate(DateTime? date) {
              if (date == null) return 'Nenhuma data selecionada';
              return '📅 ${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
            }

            return AlertDialog(
              title: Text("Adicionar Tarefa"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _taskNameController,
                    decoration: InputDecoration(labelText: 'Nome da Tarefa'),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: Text(formatDate(tempSelectedDate))),
                      TextButton(
                        onPressed: () async {
                          DateTime today = DateTime.now();
                          DateTime onlyDate = DateTime(
                            today.year,
                            today.month,
                            today.day,
                          );

                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: onlyDate,
                            firstDate: onlyDate,
                            lastDate: DateTime(2100),
                          );

                          if (pickedDate != null) {
                            setStateDialog(() {
                              tempSelectedDate = pickedDate;
                            });
                          }
                        },
                        child: Text('Selecionar Data'),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: Text("Cancelar"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  child: Text("Salvar"),
                  onPressed: () async {
                    String? uid = await getUserUid();
                    try {
                      await taskController.addTask(
                        uid: uid!,
                        taskName: _taskNameController.text,
                        dueDate: tempSelectedDate!,
                      );

                      _taskNameController.clear();
                      _selectedDate = null;

                      Get.snackbar(
                        'Sucesso!',
                        'Tarefa adicionada com sucesso!',
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                      );

                      Navigator.of(context).pop();
                    } catch (e) {
                      Get.snackbar(
                        'Erro!',
                        'Erro desconhecido ao adicionar tarefa.',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
