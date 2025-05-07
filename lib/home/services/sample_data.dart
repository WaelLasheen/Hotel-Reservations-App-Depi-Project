import '../../core/models/hotel.dart';

class SampleData {
  List<Hotel> getAllHotels() {
    return [
      Hotel(
        id: '1',
        name: 'Elysium Gardens',
        location: 'Cairo, Egypt',
        imageUrl:
            'https://images.unsplash.com/photo-1566073771259-6a8506099945',
        price: 2500,
        rating: 4.5,
        reviewCount: 128,
        facilities: ['Wi-Fi', 'Pool', 'Spa', 'Restaurant'],
        description:
            'Luxury hotel in the heart of Cairo with stunning Nile views.',
      ),
      Hotel(
        id: '2',
        name: 'Pyramids View Inn',
        location: 'Giza, Egypt',
        imageUrl: 'https://images.unsplash.com/photo-1549109786-eb80da56e693',
        price: 1800,
        rating: 4.7,
        reviewCount: 95,
        facilities: ['Wi-Fi', 'Restaurant', 'Tour Desk'],
        description: 'Experience the magic of the pyramids from your room.',
      ),
      Hotel(
        id: '3',
        name: 'Alexandria Pearl',
        location: 'Alexandria, Egypt',
        imageUrl:
            'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b',
        price: 2200,
        rating: 4.4,
        reviewCount: 156,
        facilities: ['Wi-Fi', 'Beach Access', 'Pool', 'Gym'],
        description: 'Beachfront hotel with Mediterranean charm.',
      ),
      Hotel(
        id: '4',
        name: 'Luxor Palace',
        location: 'Luxor, Egypt',
        imageUrl: 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb',
        price: 1500,
        rating: 4.2,
        reviewCount: 89,
        facilities: ['Wi-Fi', 'Pool', 'Restaurant'],
        description: 'Historic hotel near ancient temples.',
      ),
      Hotel(
        id: '5',
        name: 'Red Sea Resort',
        location: 'Hurghada, Egypt',
        imageUrl:
            'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4',
        price: 2800,
        rating: 4.6,
        reviewCount: 212,
        facilities: ['Wi-Fi', 'Private Beach', 'Spa', 'Water Sports'],
        description: 'All-inclusive resort on the Red Sea.',
      ),
      Hotel(
        id: '6',
        name: 'Oasis Palm',
        location: 'Siwa, Egypt',
        imageUrl: 'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa',
        price: 1200,
        rating: 4.1,
        reviewCount: 67,
        facilities: ['Wi-Fi', 'Pool', 'Desert Tours'],
        description: 'Unique desert experience in traditional settings.',
      ),
      Hotel(
        id: '7',
        name: 'Nile View Hotel',
        location: 'Aswan, Egypt',
        imageUrl: 'https://images.unsplash.com/photo-1561501900-3701fa6a0864',
        price: 1900,
        rating: 4.3,
        reviewCount: 143,
        facilities: ['Wi-Fi', 'Pool', 'Restaurant', 'River Tours'],
        description: 'Spectacular views of the Nile River and Nubian culture.',
      ),
      Hotel(
        id: '8',
        name: 'Marina Bay Resort',
        location: 'Sharm El Sheikh, Egypt',
        imageUrl:
            'https://images.unsplash.com/photo-1571896349842-33c89424de2d',
        price: 3200,
        rating: 4.7,
        reviewCount: 278,
        facilities: [
          'Wi-Fi',
          'Private Beach',
          'Spa',
          'Diving Center',
          'Multiple Restaurants'
        ],
        description:
            'Luxury resort with world-class diving and beach activities.',
      ),
      Hotel(
        id: '9',
        name: 'Desert Rose Lodge',
        location: 'Marsa Alam, Egypt',
        imageUrl:
            'https://images.unsplash.com/photo-1566665797739-1674de7a421a',
        price: 1600,
        rating: 4.2,
        reviewCount: 92,
        facilities: ['Wi-Fi', 'Beach Access', 'Restaurant', 'Snorkeling'],
        description: 'Peaceful getaway on the southern Red Sea coast.',
      ),
      Hotel(
        id: '10',
        name: 'Cairo Citadel Hotel',
        location: 'Cairo, Egypt',
        imageUrl:
            'https://images.unsplash.com/photo-1590073844006-33379778ae09',
        price: 2100,
        rating: 4.4,
        reviewCount: 165,
        facilities: ['Wi-Fi', 'Pool', 'Spa', 'Gym', 'City Tours'],
        description: 'Modern luxury in the heart of historic Cairo.',
      ),
    ];
  }

  List<Hotel> getPopularHotels() {
    return getAllHotels().where((hotel) => hotel.rating >= 4.4).toList();
  }

  List<Hotel> getSpecialOffers() {
    return getAllHotels().where((hotel) => hotel.price <= 2000).toList();
  }
}
