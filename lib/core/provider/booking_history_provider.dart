import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/models/booking.dart';
import 'package:flutter_application_1/database/booking_history_database_helper.dart';

class BookingHistoryProvider with ChangeNotifier {
  List<Booking> _bookings = [];

  List<Booking> get bookings => _bookings;

  Future<void> loadBookings() async {
    _bookings = await BookingDatabase.getBookings();
    notifyListeners();
  }

  Future<void> addBooking(Booking booking) async {
    await BookingDatabase.insertBooking(booking);
    // _bookings.add(booking);
    loadBookings();
    notifyListeners();
  }

  Future<void> deleteBooking(int id) async {
    await BookingDatabase.deleteBooking(id);
    loadBookings();
    // _bookings.removeWhere((b) => b.id == id);
    notifyListeners();
  }
}
