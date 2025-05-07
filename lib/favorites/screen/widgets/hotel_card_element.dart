import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/colors_manager.dart';

class HotelCardElement extends StatelessWidget {
  final Map<String, dynamic> hotel;
  final VoidCallback onRemove;
  final double screenWidth;
  final double cardWidth;
  const HotelCardElement({
    super.key,
    required this.hotel,
    required this.onRemove,
    required this.screenWidth,
    required this.cardWidth,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('${hotel['name']} clicked!');
      },
      child: Container(
        width: cardWidth,
        decoration: BoxDecoration(
          color: ColorsManager.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Section
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.network(
                    hotel['image'],
                    width: double.infinity,
                    height: screenWidth * 0.25,
                    fit: BoxFit.cover,
                  ),
                ),

                // Content Section
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Hotel Name and Rating Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Hotel Name
                          Expanded(
                            child: Text(
                              hotel['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.035,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // Rating
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: screenWidth * 0.035,
                              ),
                              SizedBox(width: screenWidth * 0.01),
                              Text(
                                '${hotel['rating']}',
                                style: TextStyle(fontSize: screenWidth * 0.03),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: screenWidth * 0.015),
                      // Price
                      Text(
                        '${hotel['price']}',
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: const Color.fromARGB(255, 1, 169, 225),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenWidth * 0.015),
                      // Location
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: const Color.fromARGB(255, 31, 146, 175),
                            size: screenWidth * 0.04,
                          ),
                          SizedBox(width: screenWidth * 0.01),
                          Expanded(
                            child: Text(
                              "${hotel['location']}",
                              style: TextStyle(
                                fontSize: screenWidth * 0.032,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenWidth * 0.005),
                      // Book Now Button
                      Container(
                        margin: const EdgeInsets.only(bottom: 2),
                        child: ElevatedButton(
                          onPressed: () {
                            print('Book now clicked for ${hotel['name']}');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff009fd4),
                            minimumSize: const Size(double.infinity, 30),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          child: Text(
                            'Book Now',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.032,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Favorite Button
            Positioned(
              top: 8.0,
              right: 8.0,
              child: GestureDetector(
                onTap: onRemove,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.favorite,
                    color: const Color.fromARGB(255, 1, 169, 225),
                    size: screenWidth * 0.043,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
