import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../models/hotel_model.dart';

class HotelController extends GetxController {
  var allHotels = <Hotel>[].obs;
  var filteredHotels = <Hotel>[].obs;

  List<Hotel> get hotels => filteredHotels.toList();

  var isLoading = true.obs;
  var minPrice = 0.obs;
  var maxPrice = 200000.obs;
  var minRating = 0.0.obs;

  var searchQuery = ''.obs;

  Timer? _debounceTimer;

  final String apiUrl = 'https://api.jsonbin.io/v3/b/6a095f58adc21f119ab1042a';

  @override
  void onInit() {
    super.onInit();
    fetchHotels();

    ever(minPrice, (_) => applyFilters());
    ever(maxPrice, (_) => applyFilters());
    ever(minRating, (_) => applyFilters());

    debounce(searchQuery, (_) => applyFilters(),
        time: const Duration(milliseconds: 400));
  }

  Future<void> fetchHotels() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> hotelsJson = data['record'];
        allHotels.value =
            hotelsJson.map((json) => Hotel.fromJson(json)).toList();
        applyFilters();
      } else {
        throw Exception('Erreur HTTP ${response.statusCode}');
      }
    } catch (e, stack) {
      print('=== ERREUR DÉTAILLÉE ===');
      print('Type: ${e.runtimeType}');
      print('Message: $e');
      print('Stack trace: $stack');
      Get.snackbar('Error', 'Failed to load hotels: $e');
    } finally {
      isLoading(false);
    }
  }

  void applyFilters() {
    var list = List<Hotel>.from(allHotels);

    list = list
        .where((h) => h.price >= minPrice.value && h.price <= maxPrice.value)
        .toList();

    list = list.where((h) => h.rating >= minRating.value).toList();

    if (searchQuery.value.isNotEmpty) {
      final q = searchQuery.value.toLowerCase().trim();
      list = list
          .where((h) =>
              h.title.toLowerCase().contains(q) ||
              h.place.toLowerCase().contains(q) ||
              h.description.toLowerCase().contains(q))
          .toList();
    }

    filteredHotels.value = list;
  }

  void setMinPrice(int v) => minPrice.value = v;
  void setMaxPrice(int v) => maxPrice.value = v;
  void setMinRating(double v) => minRating.value = v;
  void setSearchQuery(String v) => searchQuery.value = v;

  void resetFilters() {
    minPrice.value = 0;
    maxPrice.value = 200000;
    minRating.value = 0.0;
    searchQuery.value = '';
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    super.onClose();
  }
}
