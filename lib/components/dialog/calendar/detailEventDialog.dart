import 'package:estudazz_main_code/components/custom/customSnackBar.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:estudazz_main_code/constants/constSizedBox.dart';
import 'package:estudazz_main_code/services/db/calendar/eventsDB.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class DetailEventDialog {
  void showDetailEventDialog({
    required BuildContext context,
    required String eventName,
    required DateTime eventDate,
    required String eventId,
    required VoidCallback deleteEvent,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: ConstColors.grey900Color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            DateFormat('dd/MM/yyyy').format(eventDate),
            style: TextStyle(
              color: ConstColors.orangeColor,
              fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
          ),
          content: Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventName,
                  style: TextStyle(
                    color: ConstColors.whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                ConstSizedBox.h12,
                Text(
                  DateFormat('HH:mm').format(eventDate),
                  style: TextStyle(
                    color: ConstColors.white54Color,
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.edit, color: ConstColors.whiteColor),
            ),
            IconButton(
              onPressed: () async {
                await EventsDB().deleteEvent(eventId);
                CustomSnackBar.show(
                  title: 'Sucesso!',
                  message: 'Evento "$eventName" excluído com sucesso!',
                  backgroundColor: ConstColors.greenColor,
                );
                Get.back();
                deleteEvent();
              },
              icon: Icon(Icons.delete_forever, color: ConstColors.whiteColor),
            ),
            ElevatedButton(
              onPressed: () => Get.back(),
              child: Text('Fechar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: ConstColors.orangeColor,
                foregroundColor: ConstColors.whiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
