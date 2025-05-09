import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/models/hotel.dart';
import 'package:flutter_application_1/database/hotel_database_helper.dart';

class HotelProvider with ChangeNotifier {
  List<Hotel> _hotels = [];

  List<Hotel> get hotels => _hotels;

  List<Hotel> get favorites => _hotels.where((hotel) => hotel.isFavorite).toList();

  List<Hotel> getPopularHotels() {
    return _hotels.where((hotel) => hotel.rating >= 4.4).toList();
  }

  List<Hotel> getSpecialOffers() {
    return _hotels.where((hotel) => hotel.price <= 2000).toList();
  }

  Future<void> loadHotels() async {
    _hotels = await HotelDatabase.getHotels();
    notifyListeners();
  }

  void toggleFavorite(String id) async {
    final index = _hotels.indexWhere((h) => h.id == id);
    if (index != -1) {
      _hotels[index].isFavorite = !_hotels[index].isFavorite;
      await HotelDatabase.updateFavorite(id, _hotels[index].isFavorite);
      notifyListeners();
    }
  }

  Future<void> addHotel(Hotel hotel) async {
    await HotelDatabase.insertHotel(hotel);
    _hotels.add(hotel);
    notifyListeners();
  }
}
