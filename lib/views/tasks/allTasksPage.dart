import 'package:estudazz_main_code/components/dialog/task/markTaskCompletedDialog.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/controllers/tasks/taskController.dart';
import 'package:estudazz_main_code/components/dialog/task/addTaskDialog.dart';
import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:estudazz_main_code/services/db/tasks/tasksDB.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AllTasksPage extends StatefulWidget {
  const AllTasksPage({super.key});

  @override
  State<AllTasksPage> createState() => _AllTasksPageState();
}

class _AllTasksPageState extends State<AllTasksPage> {
  final TaskController _taskController = TaskController(tasksDB: TasksDB());
  final TasksDB _tasksDB = TasksDB();

  Future<String?> _getUserUid() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  void _showMarkTaskCompletedDialog(String taskId, String taskName) {
    MarkTaskCompletedDialog().showMarkTaskCompletedDialog(
      context: context,
      taskId: taskId,
      taskName: taskName,
    );
  }

  void _showAddTaskDialog() {
    AddTaskDialog().showAddTaskDialog(
      context: context,
      taskController: _taskController,
      getUserUid: _getUserUid,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleAppBar: 'Minhas Tarefas'),
      body: FutureBuilder<String?>(
        future: _getUserUid(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
            return Center(child: Text("Erro ao carregar UID do usuário."));
          }

          String uid = snapshot.data!;

          return StreamBuilder<QuerySnapshot>(
            stream: _tasksDB.getTasksByUser(uid),
            builder: (context, taskSnapshot) {
              if (taskSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (taskSnapshot.hasError) {
                return Center(
                  child: Text(
                    "Erro ao carregar tarefas: ${taskSnapshot.error} \n Contacte o suporte.",
                  ),
                );
              }

              if (!taskSnapshot.hasData || taskSnapshot.data!.docs.isEmpty) {
                return Center(child: Text("Nenhuma tarefa encontrada."));
              }

              final tasks = taskSnapshot.data!.docs;

              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  final taskName = task['task_name'] ?? "Sem nome";
                  final dueDate = task['due_date'] ?? "Sem data";
                  final taskCompleted = task['task_completed'] ?? false;

                  final formattedDueDate =
                      dueDate != "Sem data"
                          ? DateFormat(
                            "dd/MM/yyyy",
                          ).format(DateTime.parse(dueDate))
                          : "Sem data";

                  DateTime now = DateTime.now();
                  DateTime dueDateTime = DateTime.tryParse(dueDate) ?? now;

                  bool isOverdue = !taskCompleted && dueDateTime.isBefore(now);
                  String statusText;
                  IconData statusIcon;
                  Color statusColor;

                  if (taskCompleted) {
                    statusText = "Tarefa Concluída";
                    statusIcon = Icons.check_circle;
                    statusColor = ConstColors.greenColor;
                  } else if (isOverdue) {
                    statusText = "Tarefa Atrasada";
                    statusIcon = Icons.cancel;
                    statusColor = ConstColors.redColor;
                  } else {
                    statusText = "Tarefa Pendente";
                    statusIcon = Icons.warning_amber_rounded;
                    statusColor = ConstColors.yellowColor;
                  }

                  return Opacity(
                    opacity: taskCompleted ? 0.5 : 1.0,
                    child: GestureDetector(
                      onLongPress: () {
                        _showMarkTaskCompletedDialog(task.id, taskName);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: ConstColors.black54Color,
                              blurRadius: 4,
                              offset: Offset(2, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "$statusText: ",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "$taskName",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Prazo: $formattedDueDate",
                                    style: TextStyle(
                                      color: ConstColors.greyColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(statusIcon, color: statusColor, size: 32),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: ConstColors.orangeColor,
        foregroundColor: ConstColors.whiteColor,
        onPressed: _showAddTaskDialog,
        icon: Icon(Icons.add),
        label: Text('Adicionar Tarefa'),
      ),
    );
  }
}
