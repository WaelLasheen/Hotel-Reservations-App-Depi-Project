import 'package:equatable/equatable.dart';

abstract class HotelEvent extends Equatable {
  const HotelEvent();

  @override
  List<Object> get props => [];
}

class LoadHotels extends HotelEvent {
  const LoadHotels();
}

class LoadPopularHotels extends HotelEvent {
  const LoadPopularHotels();
}

class LoadSpecialOffers extends HotelEvent {
  const LoadSpecialOffers();
}

class SelectHotel extends HotelEvent {
  final String hotelId;

  const SelectHotel(this.hotelId);

  @override
  List<Object> get props => [hotelId];
} 