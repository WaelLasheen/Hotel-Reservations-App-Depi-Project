import 'package:hive/hive.dart';

part 'favorite_hotel.g.dart';

@HiveType(typeId: 2)
class FavoriteHotel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String image;

  @HiveField(3)
  final double rating;

  @HiveField(4)
  final String price;

  @HiveField(5)
  final String location;

  FavoriteHotel({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.price,
    required this.location,
  });
} 