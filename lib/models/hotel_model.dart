class Hotel {
  final int id;
  final String title;
  final String description;
  final int distance;
  final int review;
  final int price;
  final String picture;
  final String place;
  final double rating;
  final String delivery;
  final String source;

  Hotel({
    required this.id,
    required this.title,
    required this.description,
    required this.distance,
    required this.review,
    required this.price,
    required this.picture,
    required this.place,
    required this.rating,
    required this.delivery,
    required this.source,
  });

  
  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'] ?? DateTime.now().millisecondsSinceEpoch,
      title: json['title'] ?? 'Sans titre',
      description: json['description'] ?? json['snippet'] ?? '',
      distance: 0, // l’API ne donne pas de distance, on met 0
      review: (json['reviews'] as num?)?.toInt() ?? 0,
      price: (json['extracted_price'] as num?)?.toInt() ?? 0,
      picture: json['thumbnail'] ?? '',
      place: json['source'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      delivery: json['delivery'] ?? '',
      source: json['source'] ?? '',
    );
  }
}