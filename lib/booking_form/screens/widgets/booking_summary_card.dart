import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/booking_form/providers/booking_provider.dart';
import 'package:flutter_application_1/core/utils/colors_manager.dart';
import 'package:flutter_application_1/core/utils/text_styles_manager.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookingSummaryCard extends StatelessWidget {
  const BookingSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorsManager.grey300)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: bookingProvider.hotel!.imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: 100,
                height: 100,
                color: Colors.grey[200],
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                width: 100,
                height: 100,
                color: Colors.grey[200],
                child: const Icon(Icons.image, size: 30),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      bookingProvider.hotel!.name,
                      style: TextStyleManager.blackBold16,
                    ),
                    bookingProvider.hotel!.isFavorite
                        ? const Icon(Icons.favorite, color: Colors.red)
                        : Icon(Icons.favorite_border,
                            color: ColorsManager.grey600),
                  ],
                ),
                Text(bookingProvider.hotel!.location,
                    style: TextStyleManager.greyRegular14),
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                        text:
                            'EGP ${NumberFormat('#,###').format(bookingProvider.hotel!.price)}',
                        style: TextStyleManager.greyRegular14,
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
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${bookingProvider.hotel!.rating}',
                      style: TextStyleManager.blackSemiBold15,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
