class Hotel {
  final String id;
  final String name;
  final String location;
  final String imageUrl;
  final double price;
  final double rating;
  final int reviewCount;
  final List<String> facilities;
  final String description;

  Hotel({
    required this.id,
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.facilities,
    required this.description,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'] as String,
      name: json['name'] as String,
      location: json['location'] as String,
      imageUrl: json['imageUrl'] as String,
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      facilities: List<String>.from(json['facilities'] as List),
      description: json['description'] as String,
    );
  }
} 