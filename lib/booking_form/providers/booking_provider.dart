import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/models/booking.dart';
import 'package:flutter_application_1/core/models/client.dart';
import 'package:flutter_application_1/core/models/hotel.dart';
import 'package:intl/intl.dart';

class BookingProvider with ChangeNotifier {
  DateTime? _startDate;
  DateTime? _endDate;
  Hotel? _hotel;
  int _numberOfGuests = 1;
  int _numberOfRooms = 1;
  String _firstName = '';
  String _lastName = '';
  String _phoneNumber = '';
  String _email = '';
  String? _idImagePath;

  Hotel? get hotel => _hotel;
  int get numberOfGuests => _numberOfGuests;
  int get numberOfRooms => _numberOfRooms;
  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get phoneNumber => _phoneNumber;
  String get email => _email;
  String? get idImagePath => _idImagePath;

  void setHotel(Hotel hotel) {
    _hotel = hotel;
    notifyListeners();
  }

  void setDates(DateTime startDate, DateTime? endDate) {
    _startDate = startDate;
    _endDate = endDate;
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

  void setFirstName(String value) {
    if (_firstName != value) {
      _firstName = value;
      notifyListeners(); // Only notify if value changed
    }
  }

  void setLastName(String value) {
    if (_lastName != value) {
      _lastName = value;
      notifyListeners();
    }
  }

  void setEmail(String value) {
    if (_email != value) {
      _email = value;
      notifyListeners();
    }
  }

  void setPhone(String value) {
    if (_phoneNumber != value) {
      _phoneNumber = value;
      notifyListeners();
    }
  }

  void setIdImagePath(String? path) {
    if (_idImagePath != path) {
      _idImagePath = path;
      notifyListeners();
    }
  }

  int numberOfBookedDays() {
    if (_startDate == null) {
      return 0;
    } else if (_endDate == null) {
      return 1;
    }
    return _endDate!.difference(_startDate!).inDays + 1;
  }

  int calculateCost() {
    return numberOfBookedDays() * hotel!.price.toInt() * numberOfRooms;
  }

  bool isFulled() =>
      firstName.isNotEmpty &&
      lastName.isNotEmpty &&
      email.isNotEmpty &&
      phoneNumber.isNotEmpty &&
      idImagePath != null;

  String dateToString(DateTime? date) {
    date ??= DateTime.now();

    return DateFormat('MMM d').format(date);
  }

  void cleanBookingDate() {
    _startDate = null;
    _endDate = null;
    _numberOfGuests = 1;
    _numberOfRooms = 1;
    _firstName = '';
    _lastName = '';
    _phoneNumber = '';
    _email = '';
    _idImagePath = null;
    _hotel = null;
    notifyListeners();
  }

  Client buildClient() {
    return Client(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      email: email,
      idImagePath: idImagePath!,
    );
  }

  Booking buildBooking() {
    return Booking(
      hotel: hotel!,
      client: buildClient(),
      startDate: startDate!,
      endDate: endDate!,
      numberOfGuests: numberOfGuests,
      numberOfRooms: numberOfRooms,
    );
  }
}
