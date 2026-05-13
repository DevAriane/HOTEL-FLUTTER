import 'package:get/get.dart';
import 'package:hotel/models/hotel_model.dart';
import 'package:hotel/services/hotel_service.dart';
import '../data/hotel_data.dart';

class FavoritesController extends GetxController {
  var favoriteHotels = <Hotel>[].obs;

  @override
  void onInit() {
    super.onInit();

    final objectBox = Get.find<ObjectBoxService>();

    _loadFavorites(objectBox);
  }

  void _loadFavorites(ObjectBoxService objectBox) {
    final allHotelsProvider = Get.find<HotelProvider>();
    final favoriteIds = objectBox.getFavoriteIds();

    final List<Hotel> loadedFavorites = [];
    for (final id in favoriteIds) {
      final foundHotel = allHotelsProvider.hotels.firstWhereOrNull(
        (hotel) => hotel.id == id,
      );
      if (foundHotel != null) {
        loadedFavorites.add(foundHotel);
      }
    }
    favoriteHotels.assignAll(loadedFavorites);
  }

  void toggleFavorite(Hotel hotel) async {
    final objectBox = Get.find<ObjectBoxService>();

    await objectBox.toggleFavorite(hotel.id);

    if (favoriteHotels.contains(hotel)) {
      favoriteHotels.remove(hotel);
    } else {
      favoriteHotels.add(hotel);
    }
  }

  bool isFavorite(Hotel hotel) {
    return favoriteHotels.contains(hotel);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
