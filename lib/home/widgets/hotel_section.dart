import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/models/hotel.dart';
import 'hotel_card.dart';

class HotelSection extends StatelessWidget {
  final String title;
  final List<Hotel> hotels;
  final VoidCallback onViewAll;
  final Function(Hotel) onHotelTap;
  final bool isHorizontal;

  const HotelSection({
    super.key,
    required this.title,
    required this.hotels,
    required this.onViewAll,
    required this.onHotelTap,
    required this.isHorizontal,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: theme.textTheme.titleLarge),
              TextButton(
                onPressed: onViewAll,
                child: Text(
                  'View All',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (!isHorizontal)
          SizedBox(
            height: 290,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: hotels.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    right: index != hotels.length - 1 ? 16 : 0,
                  ),
                  child: GestureDetector(
                    onTap: () => onHotelTap(hotels[index]),
                    child: HotelCard(hotel: hotels[index]),
                  ),
                );
              },
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: hotels
                  .map((hotel) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: GestureDetector(
                          onTap: () => onHotelTap(hotel),
                          child: HotelCard(
                            hotel: hotel,
                            isHorizontal: true,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
      ],
    );
  }
}
