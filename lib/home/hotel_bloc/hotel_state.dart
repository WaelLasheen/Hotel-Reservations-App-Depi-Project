import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/core/models/hotel.dart';

abstract class HotelState extends Equatable {
  const HotelState();

  @override
  List<Object> get props => [];
}

class HotelInitial extends HotelState {}

class HotelLoading extends HotelState {}

class HotelLoaded extends HotelState {
  final List<Hotel> allHotels;
  final List<Hotel> popularHotels;
  final List<Hotel> specialOffers;
  final Hotel? selectedHotel;

  const HotelLoaded({
    required this.allHotels,
    required this.popularHotels,
    required this.specialOffers,
    this.selectedHotel,
  });

  @override
  List<Object> get props => [allHotels, popularHotels, specialOffers];

  HotelLoaded copyWith({
    List<Hotel>? allHotels,
    List<Hotel>? popularHotels,
    List<Hotel>? specialOffers,
    Hotel? selectedHotel,
  }) {
    return HotelLoaded(
      allHotels: allHotels ?? this.allHotels,
      popularHotels: popularHotels ?? this.popularHotels,
      specialOffers: specialOffers ?? this.specialOffers,
      selectedHotel: selectedHotel ?? this.selectedHotel,
    );
  }
}

class HotelError extends HotelState {
  final String message;

  const HotelError(this.message);

  @override
  List<Object> get props => [message];
} 