import 'package:flutter/material.dart';
import 'package:flutter_application_1/booking_form/providers/calender_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Calender extends StatelessWidget {
  const Calender({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Consumer<CalenderProvider>(
        builder: (context, calenderProvider, _) {
          return TableCalendar(
            firstDay: DateTime.now(),
            lastDay: DateTime.now().add(const Duration(days: 365)),
            focusedDay: calenderProvider.focusedDay,
            selectedDayPredicate: calenderProvider.selectedDayPredicate,
            onDaySelected: calenderProvider.onDaySelected,
            onPageChanged: calenderProvider.updateFocusedDay,
            rangeStartDay: calenderProvider.startBookingDate,
            rangeEndDay: calenderProvider.endBookingDate,
            rangeSelectionMode: RangeSelectionMode.enforced,
            calendarFormat: calenderProvider.calendarFormat,
            availableCalendarFormats: calenderProvider.availableCalendarFormats,
            onFormatChanged: calenderProvider.onFormatChanged,
          );
        },
      ),
    );
  }
}
