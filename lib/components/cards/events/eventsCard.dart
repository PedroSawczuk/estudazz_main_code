import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventsCard extends StatelessWidget {
  final String eventName;
  final DateTime eventDate;
  final VoidCallback onTap;

  const EventsCard({
    Key? key,
    required this.eventName,
    required this.eventDate,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: ConstColors.grey900Color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: ConstColors.lightBlueColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.calendar_month,
            color: ConstColors.whiteColor,
            size: 22,
          ),
        ),
        title: Text(
          eventName,
          style: TextStyle(
            color: ConstColors.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          DateFormat('dd/MM/yyyy - HH:mm').format(eventDate),
          style: TextStyle(
            color: ConstColors.whiteColor,
            fontSize: 14,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: ConstColors.whiteColor,
        ),
        onTap: onTap,
      ),
    );
  }
}
