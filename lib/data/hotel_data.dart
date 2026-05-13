import 'package:flutter/material.dart';
import '../models/hotel_model.dart';

class HotelProvider extends ChangeNotifier {
  final List<Hotel> _hotels = [
    Hotel(
      id: 1,
      title: 'Alvi 7 Hotel',
      place: 'Deido, Douala',
      description:
          "Situé en plein cœur de Deido à Douala, ALVI SEVEN est un hôtel de 6 étages qui dispose de 40 chambres climatisées.Equipé d'une salle de fête, un accès gratuit à internet, un parking, un bar et un restaurant Cet hôtel garanti un séjour confortable et paisible.",
      distance: 2,
      review: 36,
      picture: 'assets/images/hotel1.png',
      price: 25000,
    ),
    Hotel(
      id: 2,
      title: 'Kitio Hotel',
      description:
          "Bienvenue à l'Hotel Kitio's Lodge, votre second chez vous à Yaounde. L'Hotel Kitio's Lodge met tout en œuvre pour rendre votre séjour aussi agréable et relaxant que possible. C'est la raison pour laquelle autant de clients reviennent chaque année.",
      place: 'Bastos, Yaounde',
      distance: 3,
      review: 13,
      picture: 'assets/images/hotel2.png',
      price: 15000,
    ),
    Hotel(
      id: 3,
      title: 'At home Douala ',
      description:
          "Situé à Douala, l’hébergement At home Douala Cameroun possède un patio. Cet hébergement met à votre disposition un balcon, un parking privé gratuit et une connexion Wi-Fi gratuite.",
      place: 'aeroport, Douala',
      distance: 6,
      review: 88,
      picture: 'assets/images/hotel3.png',
      price: 40000,
    ),
    Hotel(
      id: 4,
      title: 'K Hotel Douala',
      description:
          "L’établissement K Hotel Douala vous accueille à Douala, à 200 mètres de ce lieu d’intérêt : Parc Bonanjo. Il comprend une salle de sport, une terrasse, un restaurant et un parking privé gratuit. Cet hôtel 4 étoiles propose un distributeur de billets et un centre d'affaires. L’établissement possède une réception ouverte 24h/24, des transferts aéroport, un service d'étage et une connexion Wi-Fi gratuite dans l’ensemble de ses locaux.",
      place: 'Bonanjo, Douala',
      distance: 11,
      review: 34,
      picture: 'assets/images/hotel4.png',
      price: 100000,
    ),
    Hotel(
      id: 5,
      title: 'Manou Hotel',
      place: 'bonamoussadi,Douala',
      description:
          "Situé à Douala, l’établissement MANOU HOTEL comprend une piscine extérieure, une salle de sport, une terrasse et un restaurant. Il possède un bar et est installé à 7,4 km de : Stade Mbappé Léppé. L’établissement propose une réception ouverte 24h/24, des transferts aéroport, un service d'étage et une connexion Wi-Fi gratuite dans l’ensemble de ses locaux.",
      distance: 6,
      review: 88,
      picture: 'assets/images/hotel5.png',
      price: 15000,
    ),
    Hotel(
      id: 6,
      title: 'Falaise Hotel',
      description:
          "L'Hotel La Falaise Bonapriso propose des hébergements à Douala, à 1,5 km de l'école française internationale Dominique Savio et à 2,8 km du parc Bonanjo. Sa réception est ouverte 24h/24, et un service d'étage est assuré. Une connexion Wi-Fi est disponible gratuitement.",
      place: 'Bonapriso, Douala',
      distance: 11,
      review: 34,
      picture: 'assets/images/hotel6.png',
      price: 100000,
    ),
  ];
  List<Hotel> get hotels => _hotels;
}
