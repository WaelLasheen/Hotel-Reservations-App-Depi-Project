import 'package:flutter_application_1/home/services/sample_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'hotel_state.dart';
import 'hotel_event.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  final SampleData hotelService;

  HotelBloc({required this.hotelService}) : super(HotelInitial()) {
    on<LoadHotels>(_onLoadHotels);
    on<SelectHotel>(_onSelectHotel);
  }

  void _onLoadHotels(LoadHotels event, Emitter<HotelState> emit) {
    emit(HotelLoading());
    try {
      final allHotels = hotelService.getAllHotels();
      final popularHotels = hotelService.getPopularHotels();
      final specialOffers = hotelService.getSpecialOffers();

      emit(HotelLoaded(
        allHotels: allHotels,
        popularHotels: popularHotels,
        specialOffers: specialOffers,
      ));
    } catch (e) {
      emit(HotelError(e.toString()));
    }
  }

  void _onSelectHotel(SelectHotel event, Emitter<HotelState> emit) {
    if (state is HotelLoaded) {
      final currentState = state as HotelLoaded;
      final selectedHotel = currentState.allHotels
          .firstWhere((hotel) => hotel.id == event.hotelId);

      emit(currentState.copyWith(selectedHotel: selectedHotel));
    }
  }
}
