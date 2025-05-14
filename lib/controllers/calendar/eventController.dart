import 'package:estudazz_main_code/components/custom/customSnackBar.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/services/db/calendar/eventsDB.dart';

class EventController {
  final EventsDB eventsDB;

  EventController({required this.eventsDB});

  Future<void> addEvent({
    required String uid,
    required String eventName,
    required DateTime eventDate,
  }) async {
    if (eventName.isEmpty) {
      CustomSnackBar.show(
        title: 'Erro!',
        message: 'O nome do evento não pode ser vazio', 
        backgroundColor: ConstColors.redColor,
      );
    }
    if (eventDate.isBefore(DateTime.now())) {
      CustomSnackBar.show(
        title: 'Erro!',
        message: 'A data do evento não pode ser no passado',
        backgroundColor: ConstColors.redColor,
      );
    }

    await eventsDB.addEvent(uid: uid, eventName: eventName, eventDate: eventDate);
  }
}
