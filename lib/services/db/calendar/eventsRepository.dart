import 'package:estudazz_main_code/models/calendar/eventModel.dart';
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

  Future<List<EventModel>> getEventsBetween(
      String uid, DateTime start, DateTime end) async {
    final snapshot = await _eventsDB.getEventsByUser(uid).first;
    final events = snapshot.docs
        .map((doc) => EventModel.fromDocument(doc.data() as Map<String, dynamic>, doc.id))
        .toList();

    return events.where((event) {
      try {
        return event.eventDate.isAfter(start) && event.eventDate.isBefore(end);
      } catch (e) {
        return false;
      }
    }).toList();
  }
}
