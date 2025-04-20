import 'package:flutter/material.dart';
import '../screens/hotel_details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hotel Booking App',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
      home: HotelDetailsScreen(
        hotel: Hotel(
          name: 'Imperial Hotel',
          pricePerNight: 269,
          rating: 4.6,
          reviewCount: 256,
          description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In leo pulvinar leo aliquam pharetra enim venenatis quam orci. Volutpat adipiscing et aenean nulla scelerisque at blandit. Sed ut turpis adipiscing nulla lectus maecenas lh...... ',
          imageUrl:
              'https://cf.bstatic.com/xdata/images/hotel/max500/607574107.jpg?k=c37c2c5df49e1e9ebbb338c3f0077e7ef73f90e35abe770927acd4e50634b45e&o',
          galleryImages: [
            'https://cf.bstatic.com/xdata/images/hotel/max1280x900/607574071.jpg?k=b529f3b53ff7fe31fc34dcfb1d4e55da137487ef0c50d3464f1196fbb62a54b7&o=&hp=1',
            'https://cf.bstatic.com/xdata/images/hotel/max500/607574112.jpg?k=d7cd50e62593631a250899e6f35edeb091bccf53010a93674d9bbd0c03e345af&o',
            'https://cf.bstatic.com/xdata/images/hotel/max500/77824581.jpg?k=c96e2be2aeca4c2f335c085c8cd4de60ab6c307bb295d14b32d88bbd4fddf396&o',
            'https://cf.bstatic.com/xdata/images/hotel/max500/607574115.jpg?k=6f532852baf8694592420be945c254711e95974ea36111a379d4ef0ecd7f0867&o',
            'https://cf.bstatic.com/xdata/images/hotel/max500/29857346.jpg?k=a87128bed9b8c6f88e97aef3b92beaa31803686b07187b3450d3470988b83ef9&o',
          ],
        ),
      ),
    );
  }
}
