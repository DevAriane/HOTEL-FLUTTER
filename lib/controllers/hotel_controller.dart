import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/hotel_model.dart';

class HotelController extends GetxController {
  var hotels = <Hotel>[].obs;

  var filteredHotels = <Hotel>[].obs;

  var minPrice = 0.0.obs;
  var maxPrice = 1000.0.obs;
  var searchTitle = ''.obs;
  var searchPlace = ''.obs;

  final String apiKey =
      '31308f471aa00606fb3302fe139b2af2f595bea5d647d85a6e17058b9f4b4fa5';

  @override
  void onInit() {
    super.onInit();
    fetchHotels();

    ever(minPrice, (_) => applyFilters());
    ever(maxPrice, (_) => applyFilters());
    ever(searchTitle, (_) => applyFilters());
    ever(searchPlace, (_) => applyFilters());
  }

  Future<void> fetchHotels() async {
    try {
      final url = Uri.parse(
          'https://serpapi.com/search.json?engine=google&q=Fresh+Bagels&location=Seattle&api_key=31308f471aa00606fb3302fe139b2af2f595bea5d647d85a6e17058b9f4b4fa5');

      print('URL appelée : $url');

      final response = await http.get(url);
      print('Code HTTP : ${response.statusCode}');

      print(
          'Début de la réponse : ${response.body.substring(0, response.body.length > 200 ? 200 : response.body.length)}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('JSON décodé avec succès. Clés principales : ${data.keys}');

        if (data.containsKey('local_results') &&
            data['local_results'].containsKey('places')) {
          List<dynamic> products = data['local_results']['places'];
          print('Nombre d\'établissements trouvés : ${products.length}');

          hotels.value = products.map((p) => Hotel.fromJson(p)).toList();
          applyFilters();
        } else {
          print('Le champ ["local_results"]["places"] est absent.');
          Get.snackbar('Erreur', 'Aucun établissement trouvé dans cette zone');
        }
      } else {
        print('Erreur HTTP ${response.statusCode}');
        print('Corps complet : ${response.body}');
        throw Exception('Erreur API - code ${response.statusCode}');
      }
    } catch (e, stack) {
      print(' Exception attrapée : $e');
      print('Stack trace : $stack');
      Get.snackbar('Erreur', 'Impossible de charger les hôtels (voir console)');
    }
  }

  void applyFilters() {
    var list = List<Hotel>.from(hotels);

    list = list
        .where((h) => h.price >= minPrice.value && h.price <= maxPrice.value)
        .toList();

    if (searchTitle.value.isNotEmpty) {
      final q = searchTitle.value.toLowerCase();
      list = list.where((h) => h.title.toLowerCase().contains(q)).toList();
    }

    if (searchPlace.value.isNotEmpty) {
      final p = searchPlace.value.toLowerCase();
      list = list.where((h) => h.place.toLowerCase().contains(p)).toList();
    }

    filteredHotels.value = list;
  }

  void setMinPrice(double v) => minPrice.value = v;
  void setMaxPrice(double v) => maxPrice.value = v;
  void setSearchTitle(String v) => searchTitle.value = v;
  void setSearchPlace(String v) => searchPlace.value = v;

  void resetFilters() {
    minPrice.value = 0;
    maxPrice.value = 1000;
    searchTitle.value = '';
    searchPlace.value = '';
    applyFilters();
  }
}
