import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/models/booking.dart';
import 'package:flutter_application_1/database/booking_history_database_helper.dart';

class BookingHistoryProvider with ChangeNotifier {
  List<Booking> _bookings = [];
  bool _isLoading = false;

  List<Booking> get bookings => _bookings;
  bool get isLoading => _isLoading;

  Future<void> loadBookings() async {
    _isLoading = true; 
    notifyListeners();
    _bookings = await BookingDatabase.getBookings();
    _isLoading = false; 
    notifyListeners();
  }

  Future<void> addBooking(Booking booking) async {
    await BookingDatabase.insertBooking(booking);
    await loadBookings(); 
    notifyListeners();
  }

  Future<void> deleteBooking(int id) async {
    await BookingDatabase.deleteBooking(id);
    await loadBookings(); 
    notifyListeners();
  }
}