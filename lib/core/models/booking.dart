import 'hotel.dart';
import 'client.dart';

class Booking {
  int? id;
  final Hotel hotel;
  final Client client;
  final DateTime startDate;
  final DateTime endDate;
  final int numberOfGuests;
  final int numberOfRooms;

  Booking({
    this.id,
    required this.hotel,
    required this.client,
    required this.startDate,
    required this.endDate,
    required this.numberOfGuests,
    required this.numberOfRooms,
  });

  Map<String, dynamic> toMap() => {
        'hotelId': hotel.id,
        'hotelData': hotel.toMap(),
        'clientData': client.toMap(),
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'numberOfGuests': numberOfGuests,
        'numberOfRooms': numberOfRooms,
      };

  factory Booking.fromMap(Map<String, dynamic> map) => Booking(
        id: map['id'],
        hotel: Hotel.fromMap(Map<String, dynamic>.from(map['hotelData'])),
        client: Client.fromMap(Map<String, dynamic>.from(map['clientData'])),
        startDate: DateTime.parse(map['startDate']),
        endDate: DateTime.parse(map['endDate']),
        numberOfGuests: map['numberOfGuests'],
        numberOfRooms: map['numberOfRooms'],
      );
}
