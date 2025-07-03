import 'package:estudazz_main_code/services/db/tasks/tasksDB.dart';

class TasksRepository {
  final TasksDB _tasksDB = TasksDB();

  Stream<Map<String, int>> getTasksStats(String uid) {
    return _tasksDB.tasksCollection
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((snapshot) {
          final total = snapshot.docs.length;
            final completed = snapshot.docs
              .where((doc) => doc['task_completed'] == true)
              .length;
          return {'total': total, 'completed': completed};
        });
  }
}
