import 'package:estudazz_main_code/services/db/calendar/eventsDB.dart';

class EventsRepository {
  final EventsDB _eventsDB = EventsDB();

  Stream<Map<String, int>> getEventsStats(String uid) {
    return _eventsDB.eventsCollection
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((snapshot) {
          final total = snapshot.docs.length;
          return {'total': total};
        });
  }
}
