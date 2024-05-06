import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  final Function(DateTime value) onChange;
  const CalendarWidget({super.key,required this.onChange,});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 16,
            )
          ],
          borderRadius: BorderRadius.circular(20)
      ),
      child: TableCalendar(
        daysOfWeekStyle: DaysOfWeekStyle(
          // weekdayStyle: AppTextStyles.black14Medium.copyWith(
          //   color: Colors.blueColor,
          // ),
          // weekendStyle: AppTextStyles.black14Medium.copyWith(
          //   color: Colors.blueColor.withOpacity(0.5),
          // ),
        ),
        daysOfWeekHeight: 30,
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          selectedDecoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
        ),
        firstDay: DateTime.now(),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: _focusedDay,
        startingDayOfWeek: StartingDayOfWeek.monday,
        locale: 'ru',
        headerStyle: HeaderStyle(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.blue,
              ),
            ),
          ),
          formatButtonVisible: false,
          titleCentered: true,
          // titleTextStyle: AppTextStyles.black16Regular.copyWith(
          //   color: Colors.blue,
          // ),
        ),
        availableGestures: AvailableGestures.all,
        selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
        onDaySelected: (selectedDay, focusedDay) {
          setState(
                () {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
              widget.onChange(selectedDay);
            },
          );
        },
      ),
    );
  }
}
