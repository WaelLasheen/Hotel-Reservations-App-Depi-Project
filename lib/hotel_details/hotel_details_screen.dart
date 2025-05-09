import 'package:flutter/material.dart';
import 'package:flutter_application_1/booking_form/providers/booking_provider.dart';
import 'package:flutter_application_1/booking_form/providers/calender_provider.dart';
import 'package:flutter_application_1/booking_form/screens/booking_form_screen_one.dart';
import 'package:flutter_application_1/core/models/hotel.dart';
import 'package:flutter_application_1/core/provider/hotel_provider.dart';
import 'package:flutter_application_1/core/utils/colors_manager.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HotelDetailsScreen extends StatelessWidget {
  final Hotel hotel;

  const HotelDetailsScreen({
    super.key,
    required this.hotel,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> galleryImages = [
      'https://cf.bstatic.com/xdata/images/hotel/max1280x900/607574071.jpg?k=b529f3b53ff7fe31fc34dcfb1d4e55da137487ef0c50d3464f1196fbb62a54b7&o=&hp=1',
      'https://cf.bstatic.com/xdata/images/hotel/max500/607574112.jpg?k=d7cd50e62593631a250899e6f35edeb091bccf53010a93674d9bbd0c03e345af&o',
      'https://cf.bstatic.com/xdata/images/hotel/max500/77824581.jpg?k=c96e2be2aeca4c2f335c085c8cd4de60ab6c307bb295d14b32d88bbd4fddf396&o',
      'https://cf.bstatic.com/xdata/images/hotel/max500/607574115.jpg?k=6f532852baf8694592420be945c254711e95974ea36111a379d4ef0ecd7f0867&o',
      'https://cf.bstatic.com/xdata/images/hotel/max500/29857346.jpg?k=a87128bed9b8c6f88e97aef3b92beaa31803686b07187b3450d3470988b83ef9&o',
    ];
    final hotelProvider = Provider.of<HotelProvider>(context);
    final bookingProvider = Provider.of<BookingProvider>(context);
    final calenderProvider = Provider.of<CalenderProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 300.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(hotel.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 40.0,
                  left: 16.0,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 40.0,
                  right: 16.0,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: IconButton(
                      icon: hotel.isFavorite
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.favorite_border,
                              color: Color(0xFF616161),
                            ),
                      onPressed: () {
                        hotelProvider.toggleFavorite(hotel.id);
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        hotel.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'EGP ${hotel.price.toInt()}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: ColorsManager.blue,
                              ),
                            ),
                            TextSpan(
                              text: '/night',
                              style: TextStyle(
                                fontSize: 15,
                                color: ColorsManager.grey600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.star, color: Colors.amber, size: 18.0),
                      const SizedBox(width: 4.0),
                      Text(
                        '${hotel.rating} (${hotel.reviewCount} reviews)',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'About',
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    hotel.description,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // action
                    },
                    child: const Text(
                      'Read More',
                      style: TextStyle(
                        color: ColorsManager.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Gallery',
                        style: TextStyle(
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          //action
                        },
                        child: Text(
                          'See more >',
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    height: 110,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: galleryImages.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: CachedNetworkImage(
                              imageUrl: galleryImages[index],
                              width: 125,
                              height: 100,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                width: 125,
                                height: 100,
                                color: Colors.grey[200],
                                child: const Center(
                                    child: CircularProgressIndicator()),
                              ),
                              errorWidget: (context, url, error) => Container(
                                width: 125,
                                height: 100,
                                color: Colors.grey[200],
                                child: const Icon(Icons.image, size: 30),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          height: 55,
                          child: OutlinedButton(
                            onPressed: () {
                              // action
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.blue[700]!),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Text(
                              'Map View',
                              style: TextStyle(
                                color: ColorsManager.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: SizedBox(
                          height: 50.0,
                          child: ElevatedButton(
                            onPressed: () {
                              bookingProvider.cleanBookingDate();
                              calenderProvider.resetDate();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => BookingFormScreenOne(
                                    hotel: hotel,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorsManager.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Text(
                              'Book Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
