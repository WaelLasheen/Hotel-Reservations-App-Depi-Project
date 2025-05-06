import 'package:flutter/material.dart';
import '../elemnts/hotel_card_element.dart';
import '../providers/favorites_provider.dart';
import '../models/hotel.dart';
import '../services/sample_data.dart';
import 'hotel_details_screen.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  void _navigateToHotelDetails(BuildContext context, String hotelId) {
    final hotel = SampleData().getAllHotels().firstWhere(
          (h) => h.id == hotelId,
          orElse: () => Hotel(
            id: hotelId,
            name: 'Hotel Not Found',
            location: 'Unknown',
            imageUrl: 'https://via.placeholder.com/400x300',
            price: 0,
            rating: 0,
            reviewCount: 0,
            facilities: [],
            description: 'Hotel details not available',
          ),
        );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HotelDetailsScreen(hotel: hotel),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Saved Hotels'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Consumer<FavoritesProvider>(
          builder: (context, favoritesProvider, child) {
            final favorites = favoritesProvider.favorites;

            if (favorites.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 64,
                      color: theme.colorScheme.primary.withOpacity(0.5),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No saved hotels yet',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Save your favorite hotels to view them here',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              );
            }

            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.02,
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final hotel = favorites[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: HotelCardElement(
                      hotel: {
                        'id': hotel.id,
                        'name': hotel.name,
                        'image': hotel.image,
                        'rating': hotel.rating,
                        'price': hotel.price,
                        'location': hotel.location,
                      },
                      screenWidth: screenWidth,
                      cardWidth: screenWidth - (screenWidth * 0.1),
                      onRemove: () => favoritesProvider.removeFromFavorites(hotel.id),
                      onTap: () => _navigateToHotelDetails(context, hotel.id),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
