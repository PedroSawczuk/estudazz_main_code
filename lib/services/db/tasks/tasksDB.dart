import 'package:cloud_firestore/cloud_firestore.dart';

class TasksDB {
  final CollectionReference tasksCollection = FirebaseFirestore.instance
      .collection('tasks');

  Future<void> addTask({
    required String uid,
    required String taskName,
    required String dueDate,
  }) async {
    await tasksCollection.add({
      'uid': uid,
      'task_name': taskName,
      'created_at': DateTime.now().toIso8601String(),
      'task_completed': false,
      'due_date': dueDate,
      'task_completed_at': null,
    });
  }

  Future<void> updateTask({
    required String taskId,
    required Map<String, dynamic> data,
  }) {
    return tasksCollection.doc(taskId).update(data);
  }

  Future<void> deleteTask(String taskId) async {
    await tasksCollection.doc(taskId).delete();
  }
  
  Future<DocumentSnapshot> getTask(String taskId) async {
    return await tasksCollection.doc(taskId).get();
  }

  Stream<QuerySnapshot> getTasksByUser(String uid) {
    return tasksCollection
      .where('uid', isEqualTo: uid)
      .orderBy('task_completed') 
      .orderBy('created_at')
      .snapshots();
  }
}
