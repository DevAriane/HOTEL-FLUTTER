import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_color.dart';
import '../models/hotel_model.dart';
import 'booking_summary_page.dart';
import '../controllers/booking_controller.dart';
import '../models/booking_entity.dart';

class Payment extends StatelessWidget {
  final Hotel hotel;
  final DateTime checkIn;
  final DateTime checkOut;
  final int nights;
  final double totalPrice;
  final int guests;
  final int bedrooms;
  final String specialRequest;

  const Payment({
    super.key,
    required this.hotel,
    required this.checkIn,
    required this.checkOut,
    required this.nights,
    required this.totalPrice,
    required this.guests,
    required this.bedrooms,
    required this.specialRequest,
  });

  @override
  Widget build(BuildContext context) {
    final BookingController bookingController = Get.find();
    return Scaffold(
      backgroundColor: AppColor.blancFume,
      appBar: AppBar(
        title: Text(
          'Veuillez confirmer votre séjour',
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.bold,
            color: AppColor.blanc,
          ),
        ),
        backgroundColor: AppColor.dGreen,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.blanc),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Résumé des prix',
              style: GoogleFonts.nunito(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColor.noir,
              ),
            ),
            const SizedBox(height: 15),
            _summaryRow('${nights} Nuit',
                _formatPrice((nights * hotel.price).toDouble())),
            _summaryRow('Taxes', _formatPrice((nights * hotel.price) * 0.15)),
            _summaryRow('Charge service', _formatPrice(0)),
            const Divider(height: 30, thickness: 1),
            _summaryRow('Montant total à payer ', _formatPrice(totalPrice),
                isTotal: true),
            const SizedBox(height: 30),
            Text(
              'Choisir le mode de payement',
              style: GoogleFonts.nunito(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColor.noir,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _paymentMethodTab('Carte', true),
                const SizedBox(width: 15),
                _paymentMethodTab('Banque', true),
              ],
            ),
            const SizedBox(height: 20),
            _cardItem('VISA', 'Ending in 4579', Icons.credit_card),
            const SizedBox(height: 12),
            _cardItem('Mastercard', 'Ending in 4579', Icons.credit_card),
            const SizedBox(height: 12),
            // TextButton.icon(
            //   onPressed: () {
            //     Get.snackbar('Info', 'Add new card feature coming soon');
            //   },
            //   icon:
            //       const Icon(Icons.add_circle_outline, color: AppColor.dGreen),
            //   label: Text(
            //     'Add New Card',
            //     style: GoogleFonts.nunito(
            //       color: AppColor.dGreen,
            //       fontWeight: FontWeight.w600,
            //     ),
            //   ),
            // ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  final nouvelleReservation = BookingEntity(
                    hotelId: hotel.id,
                    startDate: checkIn,
                    endDate: checkOut,
                    totalPrice: totalPrice.toInt(),
                    hotelTitle: hotel.title,
                    hotelPlace: hotel.place,
                    hotelPicture: hotel.picture ?? '',
                  );
                  bookingController.createNewBooking(nouvelleReservation);

                  Get.to(BookingSummaryPage(
                      hotel: hotel,
                      checkIn: checkIn,
                      checkOut: checkOut,
                      nights: nights,
                      totalPrice: totalPrice,
                      guests: guests,
                      bedrooms: bedrooms,
                      specialRequest: specialRequest));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.dGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Confirm Payment',
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.blanc,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String price, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.nunito(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? AppColor.dGreen : AppColor.noir,
            ),
          ),
          Text(
            price,
            style: GoogleFonts.nunito(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? AppColor.dGreen : AppColor.noir,
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentMethodTab(String title, bool isSelected) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.dGreen : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? AppColor.dGreen : AppColor.silver,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.nunito(
              color: isSelected ? AppColor.blanc : AppColor.noir,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardItem(String type, String ending, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColor.blanc,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.silver.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColor.dGreen, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  ending,
                  style: GoogleFonts.nunito(
                    color: AppColor.pewter,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Radio<bool>(
            value: true,
            groupValue: true,
            onChanged: (_) {},
            activeColor: AppColor.dGreen,
          ),
        ],
      ),
    );
  }

  String _formatPrice(double price) {
    return '${price.toStringAsFixed(1)} FCFA';
  }
}
