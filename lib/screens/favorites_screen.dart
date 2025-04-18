import 'package:flutter/material.dart';
import '../elemnts/hotel_card_element.dart';
import '../providers/favorites_provider.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      body: SafeArea(
        child: Consumer<FavoritesProvider>(
          builder: (context, favoritesProvider, child) {
            final favorites = favoritesProvider.favorites;

            // Calculate exact card width
            final availableWidth = screenWidth -
                (screenWidth * 0.05 * 2) -
                16; // Total width minus padding minus spacing
            final cardWidth = availableWidth / 2;

            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.02,
              ),
              child: favorites.isEmpty
                  ? const Center(
                      child: Text(
                        'No favorite hotels yet',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.72,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: favorites.length,
                      itemBuilder: (context, index) {
                        final hotel = favorites[index];
                        return HotelCardElement(
                          hotel: hotel,
                          screenWidth: screenWidth,
                          cardWidth: cardWidth,
                          onRemove: () => favoritesProvider
                              .removeFromFavorites(hotel['id']),
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
