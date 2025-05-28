import 'package:estudazz_main_code/components/custom/customSnackBar.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/constants/constSizedBox.dart';
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

    TimeOfDay? selectedTime;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text("Adicionar Evento"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _eventNameController,
                    decoration: InputDecoration(labelText: 'Nome do Evento'),
                  ),
                  ConstSizedBox.h16,
                  TextButton(
                    onPressed: () async {
                      final pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (pickedTime != null) {
                        setStateDialog(() {
                          selectedTime = pickedTime;
                        });
                      }
                    },
                    child: Row(
                      children: [
                        selectedTime == null
                            ? Text('Selecionar Horário')
                            : Text(
                              'Horário: ${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (selectedTime == null) {
                      CustomSnackBar.show(
                        title: 'Erro',
                        message: 'Selecione um horário para o evento.',
                        backgroundColor: ConstColors.redColor,
                      );
                      return;
                    }

                    final DateTime fullDateTime = DateTime(
                      eventDate.year,
                      eventDate.month,
                      eventDate.day,
                      selectedTime!.hour,
                      selectedTime!.minute,
                    );

                    String? uid = await getUserUid();

                    try {
                      await _eventController.addEvent(
                        uid: uid!,
                        eventName: _eventNameController.text,
                        eventDate: fullDateTime,
                      );

                      _eventNameController.clear();
                      Navigator.of(context).pop();

                      CustomSnackBar.show(
                        title: 'Evento Adicionado',
                        message: 'Evento adicionado com sucesso.',
                        backgroundColor: ConstColors.greenColor,
                      );
                    } catch (e) {
                      CustomSnackBar.show(
                        title: 'Erro',
                        message: 'Falha ao adicionar tarefa: $e',
                        backgroundColor: ConstColors.redColor,
                      );
                    }
                  },
                  child: Text('Salvar'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
