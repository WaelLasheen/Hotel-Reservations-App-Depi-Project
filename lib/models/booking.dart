import 'package:hive/hive.dart';

part 'booking.g.dart';

@HiveType(typeId: 1)
class Booking extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String hotelId;

  @HiveField(2)
  final String hotelName;

  @HiveField(3)
  final String imageUrl;

  @HiveField(4)
  final DateTime checkIn;

  @HiveField(5)
  final DateTime checkOut;

  @HiveField(6)
  final int guests;

  @HiveField(7)
  final double totalPrice;

  @HiveField(8)
  final String status;

  Booking({
    required this.id,
    required this.hotelId,
    required this.hotelName,
    required this.imageUrl,
    required this.checkIn,
    required this.checkOut,
    required this.guests,
    required this.totalPrice,
    required this.status,
  });
} 