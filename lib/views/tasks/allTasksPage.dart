import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:estudazz_main_code/controllers/tasks/taskController.dart';
import 'package:estudazz_main_code/services/db/tasks/tasksDB.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class AllTasksPage extends StatefulWidget {
  const AllTasksPage({Key? key}) : super(key: key);

  @override
  State<AllTasksPage> createState() => _AllTasksPageState();
}

class _AllTasksPageState extends State<AllTasksPage> {
  final TasksDB _tasksDB = TasksDB();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _taskNameController = TextEditingController();
  DateTime? _selectedDueDate;

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF1E1E1E),
        title: Text('Adicionar Nova Tarefa', style: TextStyle(color: Colors.white)),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _taskNameController,
                decoration: InputDecoration(
                  labelText: 'Digite a tarefa...',
                  labelStyle: TextStyle(color: Colors.white70),
                ),
                style: TextStyle(color: Colors.white),
                validator: (value) => TaskController.validateTaskName(value ?? ''),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.orange,
                ),
                onPressed: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(Duration(days: 1)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  if (picked != null) {
                    setState(() => _selectedDueDate = picked);
                  }
                },
                child: Text(
                  _selectedDueDate == null
                      ? 'Selecione a Data de Prazo'
                      : 'Prazo: ${DateFormat('dd/MM/yyyy').format(_selectedDueDate!)}',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _taskNameController.clear();
              _selectedDueDate = null;
              Navigator.pop(context);
            },
            child: Text('Cancelar', style: TextStyle(color: Colors.red)),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate() && _selectedDueDate != null) {
                final user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  await _tasksDB.addTask(
                    uid: user.uid,
                    refUser: user.uid,
                    taskName: _taskNameController.text.trim(),
                    dueDate: DateFormat('yyyy-MM-dd').format(_selectedDueDate!),
                  );
                  _taskNameController.clear();
                  _selectedDueDate = null;
                  Navigator.pop(context);
                }
              }
            },
            child: Text('Adicionar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: CustomAppBar(titleAppBar: 'Minhas Tarefas'),
      body: user == null
          ? Center(child: Text('Usuário não autenticado.'))
          : StreamBuilder<QuerySnapshot>(
              stream: _tasksDB.getTasksByUser(user.uid),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Erro ao carregar tarefas: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                final tasks = snapshot.data!.docs;

                if (tasks.isEmpty) {
                  return Center(child: Text('Nenhuma tarefa ainda.'));
                }

                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    final taskName = task['task_name'];
                    final dueDate = DateTime.parse(task['due_date']);
                    final isCompleted = task['task_completed'] as bool;
                    final isOverdue = !isCompleted && dueDate.isBefore(DateTime.now());

                    IconData statusIcon;
                    Color statusColor;
                    String statusLabel;

                    if (isCompleted) {
                      statusIcon = Icons.check_circle;
                      statusColor = Colors.green;
                      statusLabel = 'Tarefa Concluída:';
                    } else if (isOverdue) {
                      statusIcon = Icons.cancel;
                      statusColor = Colors.red;
                      statusLabel = 'Tarefa Vencida:';
                    } else {
                      statusIcon = Icons.warning;
                      statusColor = Colors.amber;
                      statusLabel = 'Tarefa Não Concluída:';
                    }

                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '$statusLabel $taskName',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Prazo: ${DateFormat('dd/MM/yyyy').format(dueDate)}',
                                  style: TextStyle(color: Colors.white54, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Icon(statusIcon, color: statusColor),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
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
