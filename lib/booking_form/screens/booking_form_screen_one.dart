import 'package:flutter/material.dart';
import 'package:flutter_application_1/booking_form/providers/booking_provider.dart';
import 'package:flutter_application_1/booking_form/providers/calender_provider.dart';
import 'package:flutter_application_1/booking_form/screens/booking_form_screen_two.dart';
import 'package:flutter_application_1/booking_form/screens/widgets/calender.dart';
import 'package:flutter_application_1/booking_form/screens/widgets/check_card.dart';
import 'package:flutter_application_1/booking_form/screens/widgets/custom_appbar.dart';
import 'package:flutter_application_1/booking_form/screens/widgets/custom_button.dart';
import 'package:flutter_application_1/booking_form/screens/widgets/number_selector.dart';
import 'package:flutter_application_1/core/models/hotel.dart';
import 'package:flutter_application_1/core/utils/text_styles_manager.dart';
import 'package:provider/provider.dart';

class BookingFormScreenOne extends StatelessWidget {
  final Hotel hotel;
  const BookingFormScreenOne({
    super.key,
    required this.hotel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Booking Form'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Date',
                style: TextStyleManager.blackSemiBold15,
              ),
              const Calender(),
              const SizedBox(height: 24),
              Consumer<CalenderProvider>(
                builder: (context, calenderProvider, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CheckCard(
                        title: 'Check In',
                        date: Provider.of<BookingProvider>(context,
                                listen: false)
                            .dateToString(calenderProvider.startBookingDate),
                      ),
                      CheckCard(
                        title: 'Check Out',
                        date:
                            Provider.of<BookingProvider>(context, listen: false)
                                .dateToString(calenderProvider.endBookingDate),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              Consumer<BookingProvider>(
                builder: (context, bookingProvider, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NumberSelector(
                        title: 'Guest',
                        value: bookingProvider.numberOfGuests,
                        onDecrement: bookingProvider.decrementNumberOfGuests,
                        onIncrement: bookingProvider.incrementNumberOfGuests,
                      ),
                      NumberSelector(
                        title: 'Number Of Rooms',
                        value: bookingProvider.numberOfRooms,
                        onDecrement: bookingProvider.decrementNumberOfRooms,
                        onIncrement: bookingProvider.incrementNumberOfRooms,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 36),
              Consumer2<CalenderProvider, BookingProvider>(
                builder: (context, calenderProvider, bookingProvider, _) {
                  return calenderProvider.startBookingDate != null
                      ? CustomButton(
                          text: 'continue',
                          onPressed: () {
                            bookingProvider.setDates(
                              calenderProvider.startBookingDate!,
                              calenderProvider.endBookingDate,
                            );
                            bookingProvider.setHotel(hotel);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const BookingFormScreenTwo(),
                              ),
                            );
                          },
                        )
                      : const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
