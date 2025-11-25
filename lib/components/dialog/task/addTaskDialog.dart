import 'package:estudazz_main_code/components/custom/customSnackBar.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/constants/constSizedBox.dart';
import 'package:estudazz_main_code/controllers/tasks/taskController.dart';
import 'package:flutter/material.dart';

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
                  ConstSizedBox.h10,
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
                            locale: Locale('pt', 'BR'),
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
                    if (uid == null) {
                      CustomSnackBar.show(
                        title: 'Erro!',
                        message: 'Usuário não autenticado.',
                        backgroundColor: ConstColors.redColor,
                      );
                      return;
                    }
                    if (tempSelectedDate == null) {
                       CustomSnackBar.show(
                        title: 'Erro!',
                        message: 'Selecione uma data de vencimento.',
                        backgroundColor: ConstColors.redColor,
                      );
                      return;
                    }

                    final result = await taskController.addTask(
                      uid: uid,
                      taskName: _taskNameController.text,
                      dueDate: tempSelectedDate!,
                    );

                    if (result == AddTaskResult.success) {
                      _taskNameController.clear();
                      _selectedDate = null;
                      Navigator.of(context).pop();
                      CustomSnackBar.show(
                        title: 'Tarefa adicionada',
                        message: 'A tarefa foi adicionada com sucesso.',
                        backgroundColor: ConstColors.greenColor,
                      );
                    } else if (result == AddTaskResult.emptyName) {
                      CustomSnackBar.show(
                        title: 'Erro!',
                        message: 'O nome da tarefa não pode ser vazio.',
                        backgroundColor: ConstColors.redColor,
                      );
                    } else if (result == AddTaskResult.pastDueDate) {
                       CustomSnackBar.show(
                        title: 'Erro!',
                        message: 'A data de vencimento não pode ser no passado.',
                        backgroundColor: ConstColors.redColor,
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
