import 'package:cloud_firestore/cloud_firestore.dart';

class TasksDB {
  final CollectionReference tasksCollection =
      FirebaseFirestore.instance.collection('tasks');

  Future<void> addTask({
    required String uid,
    required String refUser,
    required String taskName,
    required String dueDate,
  }) async {
    await tasksCollection.add({
      'uid': uid,
      'ref_user': refUser,
      'task_name': taskName,
      'created_at': DateTime.now().toIso8601String(),
      'task_completed': false,
      'due_date': dueDate,
    });
  }

  Stream<QuerySnapshot> getTasksByUser(String uid) {
    return tasksCollection
        .where('ref_user', isEqualTo: uid)
        .orderBy('created_at')
        .snapshots();
  }
}
