import 'package:flutter/material.dart';
import 'package:flutter_application_1/booking_form/providers/booking_provider.dart';
import 'package:flutter_application_1/booking_form/screens/booking_summary_screen.dart';
import 'package:flutter_application_1/booking_form/screens/widgets/custom_appbar.dart';
import 'package:flutter_application_1/booking_form/screens/widgets/custom_button.dart';
import 'package:flutter_application_1/booking_form/screens/widgets/custom_text_felid.dart';
import 'package:flutter_application_1/booking_form/screens/widgets/image_upload_widget.dart';
import 'package:provider/provider.dart';

class BookingFormScreenTwo extends StatelessWidget {
  const BookingFormScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Booking Form'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      label: 'First Name',
                      hint: 'Temitope',
                      onChange: bookingProvider.setFirstName,
                      initialValue: bookingProvider.firstName,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: CustomTextFormField(
                      label: 'Surname',
                      hint: 'Joshua',
                      onChange: bookingProvider.setLastName,
                      initialValue: bookingProvider.lastName,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                label: 'Email',
                hint: 'joshuatop@gmail.com',
                keyboardType: TextInputType.emailAddress,
                onChange: bookingProvider.setEmail,
                initialValue: bookingProvider.email,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                label: 'Phone',
                hint: '+2348142694576',
                keyboardType: TextInputType.phone,
                onChange: bookingProvider.setPhone,
                initialValue: bookingProvider.phoneNumber,
              ),
              const SizedBox(height: 24),
              Consumer<BookingProvider>(
                builder: (context, value, child) => ImageUploadWidget(
                  imagePath: value.idImagePath,
                  onImageSelected: value.setIdImagePath,
                  title: 'Kindly upload any valid ID',
                ),
              ),
              const SizedBox(height: 24),
              Consumer<BookingProvider>(
                builder: (context, value, child) => value.isFulled()
                    ? CustomButton(
                        text: 'Continue',
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BookingSummaryScreen(),
                            ),
                          );
                        },
                      )
                    : const SizedBox(),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
