import 'package:flutter/material.dart';
import '../../core/models/hotel.dart';

class HotelCard extends StatelessWidget {
  final Hotel? hotel;
  final bool isHorizontal;

  const HotelCard({
    super.key,
    required this.hotel,
    this.isHorizontal = false,
  });

  @override
  Widget build(BuildContext context) {
    final name = hotel?.name ?? 'Elysium Gardens';
    final location = hotel?.location ?? 'Cairo, Egypt';
    final price = hotel?.price ?? 1500;
    final rating = hotel?.rating ?? 4.5;
    final imageUrl = hotel?.imageUrl ??
        'https://images.unsplash.com/photo-1566073771259-6a8506099945';

    return Container(
      width: isHorizontal ? double.infinity : 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: isHorizontal
          ? _buildHorizontalCard(
              context,
              name,
              location,
              price,
              rating,
              imageUrl,
            )
          : _buildVerticalCard(
              context,
              name,
              location,
              price,
              rating,
              imageUrl,
            ),
    );
  }

  Widget _buildVerticalCard(
    BuildContext context,
    String name,
    String location,
    double price,
    double rating,
    String imageUrl,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                imageUrl,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 160,
                    color: Colors.grey[200],
                    child: const Icon(Icons.image, size: 50),
                  );
                },
              ),
            ),
            _buildRatingBadge(rating),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              _buildLocation(location),
              const SizedBox(height: 8),
              _buildPriceRow(context, price),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontalCard(
    BuildContext context,
    String name,
    String location,
    double price,
    double rating,
    String imageUrl,
  ) {
    return Row(
      children: [
        ClipRRect(
          borderRadius:
              const BorderRadius.horizontal(left: Radius.circular(16)),
          child: Image.network(
            imageUrl,
            height: 120,
            width: 120,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 120,
                width: 120,
                color: Colors.grey[200],
                child: const Icon(Icons.image, size: 40),
              );
            },
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    _buildRatingBadge(rating),
                  ],
                ),
                const SizedBox(height: 4),
                _buildLocation(location),
                const SizedBox(height: 8),
                _buildPriceRow(context, price),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingBadge(double rating) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, size: 16, color: Colors.amber),
          const SizedBox(width: 4),
          Text(
            rating.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocation(String location) {
    return Row(
      children: [
        const Icon(
          Icons.location_on,
          size: 14,
          color: Colors.grey,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            location,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow(BuildContext context, double price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(
                  text: 'EGP ${price.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const TextSpan(
                  text: '/night',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.favorite_border),
          onPressed: () {},
          iconSize: 20,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }
}
