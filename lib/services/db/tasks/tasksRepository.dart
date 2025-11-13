import 'package:estudazz_main_code/models/tasks/taskModel.dart';
import 'package:estudazz_main_code/services/db/tasks/tasksDB.dart';

class TasksRepository {
  final TasksDB _tasksDB = TasksDB();

  Stream<Map<String, int>> getTasksStats(String uid) {
    return _tasksDB.tasksCollection
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((snapshot) {
      final total = snapshot.docs.length;
      final completed =
          snapshot.docs.where((doc) => doc['task_completed'] == true).length;
      return {'total': total, 'completed': completed};
    });
  }

  Future<List<TaskModel>> getTasksDueBetween(
      String uid, DateTime start, DateTime end) async {
    final snapshot = await _tasksDB.getTasksByUser(uid).first;
    final tasks = snapshot.docs
        .map((doc) => TaskModel.fromDocument(doc.data() as Map<String, dynamic>, doc.id))
        .toList();

    return tasks.where((task) {
      try {
        // dueDate já é DateTime no modelo
        return task.dueDate.isAfter(start) && task.dueDate.isBefore(end);
      } catch (e) {
        return false;
      }
    }).toList();
  }
}
