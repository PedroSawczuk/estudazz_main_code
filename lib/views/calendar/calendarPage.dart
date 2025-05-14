import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:estudazz_main_code/components/dialog/calendar/addEventDialog.dart';
import 'package:estudazz_main_code/constants/color/constColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  Future<String?> _getUserUid() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleAppBar: 'Calendário'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDayLongPressed: (selectedDay, focusedDay) async {
                final todayDate = DateTime.now();
                final isFuture = selectedDay.isAfter(
                  DateTime(todayDate.year, todayDate.month, todayDate.day),
                );

                if (isFuture) {
                  final uid = await _getUserUid();

                  AddEventDialog().showAddEventDialog(
                    context: context,
                    eventId: uid!,
                    eventName: "",
                    eventDate: selectedDay,
                    getUserUid: _getUserUid,
                  );
                }
              },
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: ConstColors.accentPurpleColor,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: ConstColors.purpleColor,
                  shape: BoxShape.circle,
                ),
                markerDecoration: BoxDecoration(
                  color: ConstColors.redColor,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              locale: 'pt_BR',
            ),
          ],
        ),
      ),
    );
  }
}
