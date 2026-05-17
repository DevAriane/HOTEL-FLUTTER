import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../controllers/hotel_controller.dart';
import '../widgets/hotel_card.dart';
import '../app_color.dart';

class HomeContent extends StatelessWidget {
  final HotelController controller = Get.find<HotelController>();

  HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blancFume,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: AppColor.dGreen,
        ),
      ),
      body: Column(
        children: [
          const HeaderSearchSection(),
          const SizedBox(height: 8),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.filteredHotels.isEmpty) {
                return Center(
                  child: Text(
                    'Aucun hotel trouvees',
                    style: GoogleFonts.nunito(color: AppColor.pewter),
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 10,
                  top: 2,
                  bottom: 85,
                ),
                itemCount: controller.filteredHotels.length,
                itemBuilder: (context, index) {
                  final hotel = controller.filteredHotels[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: HotelCard(hotel),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class HeaderSearchSection extends StatelessWidget {
  const HeaderSearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    final HotelController controller = Get.find<HotelController>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColor.dGreen, AppColor.vertOlive],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomInputFields(
            icon: Icons.search,
            hint: 'Rechercher un hôtel, une ville...',
            onChanged: controller.setSearchQuery,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _buildPriceFilter(controller)),
              const SizedBox(width: 15),
              Expanded(child: _buildRatingFilter(controller)),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () => controller.applyFilters(),
              icon: Icon(Icons.search, color: AppColor.dGreen, size: 24),
              label: Text(
                'Chercher',
                style: GoogleFonts.nunito(
                  color: AppColor.dGreen,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceFilter(HotelController controller) {
    return Obx(() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Prix max (FCFA)',
                  style: TextStyle(color: Colors.white70, fontSize: 12)),
              Row(
                children: [
                  Expanded(
                    child: Slider(
                      value: controller.maxPrice.value.toDouble(),
                      min: 0,
                      max: 200000,
                      divisions: 20,
                      activeColor: Colors.white,
                      inactiveColor: Colors.white30,
                      onChanged: (val) => controller.setMaxPrice(val.toInt()),
                    ),
                  ),
                  Text('${controller.maxPrice.value}',
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
        ));
  }

  Widget _buildRatingFilter(HotelController controller) {
    return Obx(() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nbre d'étoile min",
                  style: TextStyle(color: Colors.white70, fontSize: 12)),
              Row(
                children: [
                  Expanded(
                    child: Slider(
                      value: controller.minRating.value,
                      min: 0,
                      max: 5,
                      divisions: 10,
                      activeColor: Colors.white,
                      inactiveColor: Colors.white30,
                      onChanged: (val) => controller.setMinRating(val),
                    ),
                  ),
                  Text('${controller.minRating.value}',
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
        ));
  }
}

class CustomInputFields extends StatelessWidget {
  final IconData icon;
  final String hint;
  final Function(String)? onChanged;

  const CustomInputFields({
    super.key,
    required this.icon,
    required this.hint,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              style: GoogleFonts.nunito(color: Colors.white),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: GoogleFonts.nunito(
                    color: Colors.white.withValues(alpha: 0.7)),
                border: InputBorder.none,
                isDense: true,
              ),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
