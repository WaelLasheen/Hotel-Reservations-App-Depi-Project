import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderProvider with ChangeNotifier {
  DateTime? _startBookingDate;
  DateTime? _endBookingDate;
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  Map<CalendarFormat, String> availableCalendarFormats = {
    CalendarFormat.month: 'Month',
    CalendarFormat.twoWeeks: '2 Weeks',
  };

  DateTime? get startBookingDate => _startBookingDate;
  DateTime? get endBookingDate => _endBookingDate;
  DateTime get focusedDay => _focusedDay;
  CalendarFormat get calendarFormat => _calendarFormat;

  void _fixDateSwap() {
    // if user start with ending date then select start date we need to handel this case
    if (startBookingDate!.isAfter(endBookingDate!)) {
      DateTime temp = startBookingDate!;
      _startBookingDate = endBookingDate;
      _endBookingDate = temp;
    }
  }

  void updateFocusedDay(DateTime day) {
    if (focusedDay != day) {
      _focusedDay = day;
      notifyListeners();
    }
  }

  void onDaySelected(selectedDay, focusedDay) {
    if (startBookingDate == null) {
      _startBookingDate = selectedDay;
    } else if (endBookingDate == null) {
      _endBookingDate = selectedDay;
      _fixDateSwap();
    } else {
      _startBookingDate = selectedDay;
      _endBookingDate = null;
    }

    _focusedDay = focusedDay;

    notifyListeners();
  }

  bool selectedDayPredicate(DateTime day) {
    if (startBookingDate == null && endBookingDate == null) {
      return false;
    } else if (startBookingDate != null && endBookingDate == null) {
      return day == startBookingDate;
    } else {
      DateTime normalizedStart = DateTime(
        startBookingDate!.year,
        startBookingDate!.month,
        startBookingDate!.day,
      );
      DateTime normalizedEnd = DateTime(
        endBookingDate!.year,
        endBookingDate!.month,
        endBookingDate!.day,
      );
      DateTime normalizedDay = DateTime(day.year, day.month, day.day);

      return normalizedDay
              .isAfter(normalizedStart.subtract(const Duration(days: 1))) &&
          normalizedDay.isBefore(normalizedEnd.add(const Duration(days: 1)));
    }
  }

  void updateDateRange(DateTime? start, DateTime? end, DateTime focusedDay) {
    _startBookingDate = start;
    _endBookingDate = end;
    notifyListeners();
  }

  void onFormatChanged(CalendarFormat format) {
    if (_calendarFormat != format) {
      _calendarFormat = format;
      notifyListeners();
    }
  }

  void resetDate(){
    _startBookingDate = null;
    _endBookingDate = null;
    notifyListeners();
  }
}
