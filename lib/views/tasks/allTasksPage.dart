import 'package:estudazz_main_code/controllers/tasks/taskController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:estudazz_main_code/services/db/tasks/tasksDB.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllTasksPage extends StatefulWidget {
  const AllTasksPage({super.key});

  @override
  State<AllTasksPage> createState() => _AllTasksPageState();
}

class _AllTasksPageState extends State<AllTasksPage> {
  final TextEditingController _taskNameController = TextEditingController();
  DateTime? _selectedDate;
  final TaskController _taskController = TaskController(tasksDB: TasksDB());

  Future<String?> _getUserUid() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  void _showAddTaskDialog() {
    DateTime? tempSelectedDate = _selectedDate;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            String formatDate(DateTime? date) {
              if (date == null) return 'Nenhuma data selecionada';
              return 'Data: ${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
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
                    String? uid = await _getUserUid();

                    if (uid == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Você precisa estar logado para adicionar uma tarefa",
                          ),
                        ),
                      );
                      Navigator.of(context).pop();
                      return;
                    }

                    try {
                      await _taskController.addTask(
                        uid: uid,
                        taskName: _taskNameController.text,
                        dueDate: tempSelectedDate!,
                      );

                      _taskNameController.clear();
                      _selectedDate = null;

                      Get.snackbar(
                        'Sucesso!',
                        'Tarefa criada com sucesso.',
                        snackPosition: SnackPosition.BOTTOM,
                      );

                      Navigator.of(context).pop();
                    } catch (e) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(e.toString())));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleAppBar: 'Minhas Tarefas'),
      body: Center(child: Text("Lista de Tarefas")),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xFFED820E),
        foregroundColor: Colors.white,
        onPressed: _showAddTaskDialog,
        icon: Icon(Icons.add),
        label: Text('Adicionar Tarefa'),
      ),
    );
  }
}
