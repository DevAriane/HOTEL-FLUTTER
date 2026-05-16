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
    int parsedPrice = 0;
    if (json['price'] != null) {
      final RegExp priceRegex = RegExp(r'\d+');
      final match = priceRegex.firstMatch(json['price'].toString());
      if (match != null) {
        parsedPrice = int.tryParse(match.group(0)!) ?? 0;
      }
    }

    return Hotel(
      id: json['place_id'] is int
          ? json['place_id']
          : (int.tryParse(json['place_id']?.toString() ?? '') ??
              DateTime.now().millisecondsSinceEpoch),
      title: json['title'] ?? 'Sans titre',
      description: json['description'] ?? json['type'] ?? '',
      distance: 0,
      review: json['reviews'] is num ? (json['reviews'] as num).toInt() : 0,
      price: parsedPrice,
      picture: json['thumbnail'] ?? '',
      place: json['address'] ?? '',
      rating: json['rating'] is num ? (json['rating'] as num).toDouble() : 0.0,
      delivery: json['hours'] ?? '',
      source: json['provider_id'] ?? '',
    );
  }
}
