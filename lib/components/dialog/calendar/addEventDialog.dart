import 'package:estudazz_main_code/controllers/calendar/eventController.dart';
import 'package:estudazz_main_code/services/db/calendar/eventsDB.dart';
import 'package:flutter/material.dart';

class AddEventDialog {
  final EventController _eventController = EventController(
    eventsDB: EventsDB(),
  );

  Future<void> showAddEventDialog({
    required BuildContext context,
    required String eventId,
    required String eventName,
    required DateTime eventDate,
    required Future<String?> Function() getUserUid,
  }) async {
    final TextEditingController _eventNameController = TextEditingController(
      text: eventName,
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text("Adicionar Evento"),
              content: TextField(
                controller: _eventNameController,
                decoration: InputDecoration(labelText: 'Nome do Evento'),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancelar'),
                ),
                ElevatedButton(onPressed: () async {
                  String? uid = await getUserUid();
                  try {
                    await _eventController.addEvent(
                      uid: uid!,
                      eventName: _eventNameController.text,
                      eventDate: eventDate,
                    );
                  } catch (e) {
                    
                  }
                }, child: Text('Salvar')),
              ],
            );
          },
        );
      },
    );
  }
}
