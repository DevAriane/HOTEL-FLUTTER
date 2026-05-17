class Hotel {
  final int id;
  final String title;
  final String description;
  final double distance;
  final int review;
  final int price;
  final String picture;
  final String place;
  final double rating;
  final String delivery;
  final String source;

  Hotel(
      {required this.id,
      required this.title,
      required this.description,
      required this.distance,
      required this.review,
      required this.price,
      required this.picture,
      required this.place,
      required this.rating,
      required this.delivery,
      required this.source});

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      distance: (json['distance'] ?? 0).toDouble(),
      review: json['review'] ?? 0,
      price: json['price'] ?? 0,
      picture: json['picture'] ?? '',
      place: json['place'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      delivery: json['delivery'] ?? '',
      source: json['source'] ?? '',
    );
  }
}
