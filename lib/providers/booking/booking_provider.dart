import 'package:flutter/material.dart';

class BookingProvider extends ChangeNotifier {
  DateTime? _startDate;
  DateTime? _endDate;
  int _numberOfGuests = 1;
  int _numberOfRooms = 1;
  int _roomPrice = 0;

  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;
  int get numberOfGuests => _numberOfGuests;
  int get numberOfRooms => _numberOfRooms;
  int get roomPrice => _roomPrice;

  void setDates(DateTime start, DateTime? end) {
    _startDate = start;
    _endDate = end;
    notifyListeners();
  }

  void setRoomPrice(int price) {
    _roomPrice = price;
    notifyListeners();
  }

  void incrementNumberOfGuests() {
    _numberOfGuests++;
    notifyListeners();
  }

  void decrementNumberOfGuests() {
    if (_numberOfGuests > 1) {
      _numberOfGuests--;
      notifyListeners();
    }
  }

  void incrementNumberOfRooms() {
    _numberOfRooms++;
    notifyListeners();
  }

  void decrementNumberOfRooms() {
    if (_numberOfRooms > 1) {
      _numberOfRooms--;
      notifyListeners();
    }
  }

  String dateToString(DateTime? date) {
    if (date == null) return 'Not selected';
    return '${date.day}/${date.month}/${date.year}';
  }

  int calculateTotalPrice() {
    if (_startDate == null || _endDate == null) return 0;
    final days = _endDate!.difference(_startDate!).inDays;
    return days * _roomPrice * _numberOfRooms;
  }
} 