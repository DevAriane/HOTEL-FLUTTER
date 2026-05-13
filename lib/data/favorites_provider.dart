import 'package:flutter/material.dart';
import '../models/hotel_model.dart';

class FavoritesProvider extends ChangeNotifier {
  final Set<int> _favoriteIds = {};

  Set<int> get favoriteIds => _favoriteIds;

  void toogleFavorites(int hotelId) {
    if (_favoriteIds.contains(hotelId)) {
      _favoriteIds.remove(hotelId);
    } else {
      _favoriteIds.add(hotelId);
    }
    notifyListeners();
  }

  bool isFavorite(int hotelId) {
    return _favoriteIds.contains(hotelId);
  }

  List<Hotel> getFavoriteHotels(List<Hotel> allHotels) {
    return allHotels.where((hotel) => _favoriteIds.contains(hotel.id)).toList();
  }
}
