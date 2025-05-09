import 'package:flutter_application_1/core/models/booking.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';

class BookingDatabase {
  static Database? _db;

  static Future<Database> getDatabase() async {
    if (_db != null) return _db!;
    final path = join(await getDatabasesPath(), 'bookings.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE bookings(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            hotelId TEXT,
            hotelData TEXT,
            clientData TEXT,
            startDate TEXT,
            endDate TEXT,
            numberOfGuests INTEGER,
            numberOfRooms INTEGER
          )
        ''');
      },
    );
    return _db!;
  }

  static Future<void> insertBooking(Booking booking) async {
    final db = await getDatabase();
    await db.insert('bookings', {
      'hotelId': booking.hotel.id,
      'hotelData': jsonEncode(booking.hotel.toMap()),
      'clientData': jsonEncode(booking.client.toMap()),
      'startDate': booking.startDate.toIso8601String(),
      'endDate': booking.endDate.toIso8601String(),
      'numberOfGuests': booking.numberOfGuests,
      'numberOfRooms': booking.numberOfRooms,
    });
  }

  static Future<List<Booking>> getBookings() async {
    final db = await getDatabase();
    final maps = await db.query('bookings');
    return maps.map((map) {
      return Booking.fromMap({
        ...map,
        'hotelData': jsonDecode(map['hotelData'] as String),
        'clientData': jsonDecode(map['clientData'] as String),
      });
    }).toList();
  }

  static Future<void> deleteBooking(int id) async {
  final db = await getDatabase();
  await db.delete(
    'bookings',
    where: 'id = ?',
    whereArgs: [id],
  );
}

}
