import 'package:estudazz_main_code/services/db/calendar/eventsDB.dart';

enum AddEventResult { success, emptyName, pastDate }

class EventController {
  final EventsDB eventsDB;

  EventController({required this.eventsDB});

  Future<AddEventResult> addEvent({
    required String uid,
    required String eventName,
    required DateTime eventDate,
  }) async {
    if (eventName.isEmpty) {
      return AddEventResult.emptyName;
    }
    if (eventDate.isBefore(DateTime.now())) {
      return AddEventResult.pastDate;
    }

    await eventsDB.addEvent(uid: uid, eventName: eventName, eventDate: eventDate);
    return AddEventResult.success;
  }
}