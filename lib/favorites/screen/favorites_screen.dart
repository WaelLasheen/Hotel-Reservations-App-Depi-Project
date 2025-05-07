import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/models/hotel.dart';
import 'package:flutter_application_1/core/provider/hotel_provider.dart';
import 'package:flutter_application_1/core/utils/colors_manager.dart';
import 'package:flutter_application_1/favorites/screen/widgets/hotel_card_element.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: SafeArea(
        child: Consumer<HotelProvider>(
          builder: (context, favoritesProvider, _) {
            final List<Hotel> favorites = favoritesProvider.favorites;

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
                        childAspectRatio: 0.7,
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
                          onRemove: () => favoritesProvider.toggleFavorite(hotel.id),
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
