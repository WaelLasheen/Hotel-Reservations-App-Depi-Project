import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/favorite_hotel.dart';

class FavoritesProvider extends ChangeNotifier {
  static const String _boxName = 'favorites';
  late Box<FavoriteHotel> _favoritesBox;
  List<FavoriteHotel> _favorites = [];

  FavoritesProvider() {
    _initBox();
  }

  Future<void> _initBox() async {
    _favoritesBox = await Hive.openBox<FavoriteHotel>(_boxName);
    _favorites = _favoritesBox.values.toList();
    notifyListeners();
  }

  List<FavoriteHotel> get favorites => _favorites;

  Future<void> addToFavorites(Map<String, dynamic> hotel) async {
    if (!_favorites.any((h) => h.id == hotel['id'])) {
      final favoriteHotel = FavoriteHotel(
        id: hotel['id'],
        name: hotel['name'],
        image: hotel['image'],
        rating: hotel['rating'] is double ? hotel['rating'] : double.parse(hotel['rating'].toString()),
        price: hotel['price'],
        location: hotel['location'],
      );
      await _favoritesBox.put(hotel['id'], favoriteHotel);
      _favorites = _favoritesBox.values.toList();
      notifyListeners();
    }
  }

  Future<void> removeFromFavorites(String hotelId) async {
    await _favoritesBox.delete(hotelId);
    _favorites = _favoritesBox.values.toList();
    notifyListeners();
  }

  bool isFavorite(String hotelId) {
    return _favorites.any((hotel) => hotel.id == hotelId);
  }
}
