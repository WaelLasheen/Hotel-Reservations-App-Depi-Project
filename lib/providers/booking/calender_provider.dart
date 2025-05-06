import 'package:flutter/material.dart';

class CalenderProvider extends ChangeNotifier {
  DateTime? _startBookingDate;
  DateTime? _endBookingDate;

  DateTime? get startBookingDate => _startBookingDate;
  DateTime? get endBookingDate => _endBookingDate;

  void setBookingDate(DateTime date) {
    // Normalize the date to start of day
    final normalizedDate = DateTime(date.year, date.month, date.day);
    final today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    // If the selected date is before today, ignore it
    if (normalizedDate.isBefore(today)) {
      return;
    }

    // If no dates are selected, set as start date
    if (_startBookingDate == null) {
      _startBookingDate = normalizedDate;
    }
    // If only start date is selected, set as end date
    else if (_endBookingDate == null) {
      // Ensure end date is not before start date
      if (normalizedDate.isBefore(_startBookingDate!)) {
        return;
      }
      _endBookingDate = normalizedDate;
    }
    // If both dates are selected, reset and set new start date
    else {
      _startBookingDate = normalizedDate;
      _endBookingDate = null;
    }
    notifyListeners();
  }

  void resetDates() {
    _startBookingDate = null;
    _endBookingDate = null;
    notifyListeners();
  }

  // Helper method to check if a date is within the selected range
  bool isDateInRange(DateTime date) {
    if (_startBookingDate == null || _endBookingDate == null) {
      return false;
    }
    return date.isAfter(_startBookingDate!.subtract(const Duration(days: 1))) &&
           date.isBefore(_endBookingDate!.add(const Duration(days: 1)));
  }
} 