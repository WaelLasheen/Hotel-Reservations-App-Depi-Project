import 'package:flutter/foundation.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _favorites = [
    {
      'id': '1',
      'name': 'Luxury Hotel',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQjxd4Of0eve9hbihEVMk3Opp0YNEiNqhQGg&s',
      'rating': 4.5,
      'price': '\$95/night',
      'location': 'Paris, France'
    },
    {
      'id': '2',
      'name': 'Imperial Hotel',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQjxd4Of0eve9hbihEVMk3Opp0YNEiNqhQGg&s',
      'rating': 4.8,
      'price': '\$120/night',
      'location': 'Paris, France'
    },
    {
      'id': '3',
      'name': 'A Hotel',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQjxd4Of0eve9hbihEVMk3Opp0YNEiNqhQGg&s',
      'rating': 4.8,
      'price': '\$120/night',
      'location': 'Paris, France'
    },
    {
      'id': '4',
      'name': 'A Hotel',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQjxd4Of0eve9hbihEVMk3Opp0YNEiNqhQGg&s',
      'rating': 4.8,
      'price': '\$120/night',
      'location': 'Paris, France'
    },
  ];

  List<Map<String, dynamic>> get favorites => _favorites;

  void removeFromFavorites(String hotelId) {
    _favorites.removeWhere((hotel) => hotel['id'] == hotelId);
    notifyListeners();
  }
}
