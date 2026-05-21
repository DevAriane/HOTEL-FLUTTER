import 'package:get/get.dart';
import 'package:hotel/models/booking_entity.dart';
import 'package:hotel/models/favorite_entity.dart';
import '../models/booking_entity.dart';

class ObjectBoxService extends GetxService {
  final List<FavoriteEntity> _favorites = [];
  final List<BookingEntity> _bookings = [];
  int _nextFavoriteId = 1;
  int _nextBookingId = 1;

  Future<ObjectBoxService> init() async {
    return this;
  }

  FavoriteEntity? _findFavoriteByHotelId(int hotelId) {
    for (final favorite in _favorites) {
      if (favorite.hotelId == hotelId) {
        return favorite;
      }
    }
    return null;
  }

  Future<void> toggleFavorite(int hotelId) async {
    final existing = _findFavoriteByHotelId(hotelId);

    if (existing != null) {
      _favorites.removeWhere((favorite) => favorite.id == existing.id);
      return;
    }

    _favorites.add(
      FavoriteEntity(
        id: _nextFavoriteId++,
        hotelId: hotelId,
      ),
    );
  }

  List<int> getFavoriteIds() {
    return _favorites.map((favorite) => favorite.hotelId).toList();
  }

  bool isFavorite(int hotelId) {
    return _findFavoriteByHotelId(hotelId) != null;
  }

  Future<void> addBooking(BookingEntity booking) async {
    _bookings.add(
      BookingEntity(
        id: _nextBookingId++,
        hotelId: booking.hotelId,
        startDate: booking.startDate,
        endDate: booking.endDate,
        totalPrice: booking.totalPrice,
        hotelTitle: booking.hotelTitle,
        hotelPlace: booking.hotelPlace,
        hotelPicture: booking.hotelPicture,
      ),
    );
  }

  List<BookingEntity> getAllBookings() {
    final allBookings = List<BookingEntity>.from(_bookings);
    allBookings.sort((a, b) => b.startDate.compareTo(a.startDate));
    return allBookings;
  }
}
