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
}
