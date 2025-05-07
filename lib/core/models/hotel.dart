class Hotel {
  final String id;
  final String name;
  final String location;
  final String imageUrl;
  final double price;
  final double rating;
  final int reviewCount;
  final String description;
  bool isFavorite;

  Hotel({
    required this.id,
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.description,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'imageUrl': imageUrl,
      'price': price,
      'rating': rating,
      'reviewCount': reviewCount,
      'description': description,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  factory Hotel.fromMap(Map<String, dynamic> map) {
    return Hotel(
      id: map['id'],
      name: map['name'],
      location: map['location'],
      imageUrl: map['imageUrl'],
      price: map['price'],
      rating: map['rating'],
      reviewCount: map['reviewCount'],
      description: map['description'],
      isFavorite: map['isFavorite'] == 1,
    );
  }
}