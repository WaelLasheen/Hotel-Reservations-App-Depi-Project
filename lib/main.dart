import 'package:flutter/material.dart';
import 'package:flutter_application_1/booking_form/controllers/booking_provider.dart';
import 'package:flutter_application_1/booking_form/controllers/calender_provider.dart';
import 'package:flutter_application_1/booking_form/screens/booking_form_screen_one.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CalenderProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
      ],
      child: MaterialApp(
        title: 'Booking App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const BookingFormScreenOne(
          costPerRoomPerDay: 100,
        ),
      ),
    );
  }
}
