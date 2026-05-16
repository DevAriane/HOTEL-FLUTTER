import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hotel/app_color.dart';
import '../controllers/hotel_controller.dart';
import 'search_results_page.dart';
import 'package:get/get.dart';
import 'package:hotel/widgets/hotel_card.dart';
import 'filter_page.dart';

class HomeContent extends StatelessWidget {
  final HotelController controller = Get.find<HotelController>();

  HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: AppColor.vertFeuille,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SearchSection(),
            const HotelSection(),
          ],
        ),
      ),
    );
  }
}

class SearchSection extends StatefulWidget {
  const SearchSection({super.key});

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 40),
      decoration: BoxDecoration(
        color: AppColor.vertFeuille,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Douala',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Bouton de validation de recherche
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_forward,
                  color: AppColor.vertFeuille, size: 24),
              onPressed: () {
                final query = _searchController.text.trim();
                if (query.isEmpty) {
                  Get.snackbar(
                    "Attention",
                    "Veuillez entrer le nom d'un hôtel",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.white,
                    colorText: Colors.black,
                  );
                  return;
                }
                Get.to(() => SearchResultsPage(SearchQuery: query));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HotelSection extends StatelessWidget {
  const HotelSection({super.key});

  @override
  Widget build(BuildContext context) {
    final HotelController controller = Get.find<HotelController>();

    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => Text(
                      ' ${controller.filteredHotels.length} Trouvés',
                      style:
                          GoogleFonts.nunito(color: Colors.black, fontSize: 15),
                    )),
                Row(
                  children: [
                    Text('Filtres',
                        style: GoogleFonts.nunito(
                            color: Colors.black, fontSize: 15)),
                    IconButton(
                      icon: const Icon(Icons.filter_list_outlined,
                          color: Colors.green, size: 25),
                      onPressed: () {
                        Get.to(() => FilterPage());
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Obx(() {
            if (controller.filteredHotels.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "Aucun hôtel trouvé",
                    style: GoogleFonts.nunito(fontSize: 16, color: Colors.grey),
                  ),
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.filteredHotels.length,
              itemBuilder: (context, index) {
                final hotel = controller.filteredHotels[index];
                return HotelCard(hotel);
              },
            );
          }),
        ],
      ),
    );
  }
}
