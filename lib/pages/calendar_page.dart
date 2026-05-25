import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import '../app_color.dart';
import '../models/hotel_model.dart';
import 'payement.dart';

final DateTime kNow = DateTime.now();
final DateTime kFirstDay = DateTime(kNow.year, kNow.month - 3, kNow.day);
final DateTime kLastDay = DateTime(kNow.year, kNow.month + 3, kNow.day);

class CalendarPage extends StatefulWidget {
  final Hotel hotel;

  const CalendarPage({super.key, required this.hotel});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime? _checkIn;
  DateTime? _checkOut;
  int _guestCount = 1;
  int _bedroomCount = 1;
  String _specialRequest = '';

  final TextEditingController _requestController = TextEditingController();

  @override
  void dispose() {
    _requestController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Choisir';
    return '${date.day} ${_monthAbbr(date.month)} ${date.year}';
  }

  String _monthAbbr(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  int get _nights {
    if (_checkIn == null || _checkOut == null) return 0;
    return _checkOut!.difference(_checkIn!).inDays;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blancFume,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Réservation",
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColor.noir,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColor.blanc,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        "Choisissez la date",
                        style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColor.noir,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: _dateCard(
                              "S'enregistrer",
                              _formatDate(_checkIn),
                              onTap: () => _showCalendarModal(isCheckIn: true),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _dateCard(
                              "Vérifier",
                              _formatDate(_checkOut),
                              onTap: () => _showCalendarModal(isCheckIn: false),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Text(
                        "Chambre et Place",
                        style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColor.noir,
                        ),
                      ),
                      const SizedBox(height: 25),
                      _guestRow("Place", _guestCount, (v) {
                        setState(() => _guestCount = v);
                      }),
                      const SizedBox(height: 20),
                      _guestRow("Chambre", _bedroomCount, (v) {
                        setState(() => _bedroomCount = v);
                      }),
                      const SizedBox(height: 30),
                      Text(
                        "Besoin spécifique",
                        style: GoogleFonts.nunito(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColor.noir,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        height: 120,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: AppColor.blancFume,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: AppColor.silver.withValues(alpha: 0.3),
                          ),
                        ),
                        child: TextField(
                          maxLines: 5,
                          controller: _requestController,
                          onChanged: (value) => _specialRequest = value,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Tapez votre message ici..",
                            hintStyle:
                                GoogleFonts.nunito(color: AppColor.silver),
                          ),
                          style: GoogleFonts.nunito(color: AppColor.noir),
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (_checkIn != null && _checkOut != null)
                        Center(
                          child: Text(
                            "${_formatDate(_checkIn)} - ${_formatDate(_checkOut)} ($_nights nuits)",
                            style: GoogleFonts.nunito(
                              color: AppColor.pewter,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.dGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 0,
                          ),
                          onPressed: () {
                            if (_checkIn != null && _checkOut != null) {
                              final nights =
                                  _checkOut!.difference(_checkIn!).inDays;
                              final totalPrice = nights * widget.hotel.price;
                              Get.to(
                                Payment(
                                  hotel: widget.hotel,
                                  checkIn: _checkIn!,
                                  checkOut: _checkOut!,
                                  nights: nights,
                                  totalPrice: totalPrice.toDouble(),
                                  guests: _guestCount,
                                  bedrooms: _bedroomCount,
                                  specialRequest: _specialRequest,
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Veuillez sélectionner vos dates d'arrivée et de départ",
                                  ),
                                ),
                              );
                            }
                          },
                          child: Text(
                            "Suivant",
                            style: GoogleFonts.nunito(
                              color: AppColor.blanc,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _dateCard(String title, String date, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
        decoration: BoxDecoration(
          color: AppColor.blancFume,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColor.silver.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColor.blanc,
                borderRadius: BorderRadius.circular(10),
              ),
              child:
                  Icon(Icons.calendar_month_outlined, color: AppColor.dGreen),
            ),
            const SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w700,
                    color: AppColor.noir,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  date,
                  style: GoogleFonts.nunito(
                    color: AppColor.pewter,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _guestRow(String title, int value, Function(int) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.nunito(fontSize: 15, color: AppColor.noir),
        ),
        Row(
          children: [
            _counterButton(Icons.remove, active: false, onPressed: () {
              if (value > 1) onChanged(value - 1);
            }),
            const SizedBox(width: 15),
            Text(
              value.toString(),
              style: GoogleFonts.nunito(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColor.noir,
              ),
            ),
            const SizedBox(width: 15),
            _counterButton(Icons.add, active: true, onPressed: () {
              onChanged(value + 1);
            }),
          ],
        ),
      ],
    );
  }

  Widget _counterButton(IconData icon,
      {required bool active, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: active ? AppColor.dGreen : AppColor.blanc,
          border: Border.all(color: AppColor.silver),
        ),
        child: Icon(icon,
            size: 18, color: active ? AppColor.blanc : AppColor.silver),
      ),
    );
  }

  void _showCalendarModal({required bool isCheckIn}) {
    DateTime? rangeStart = _checkIn;
    DateTime? rangeEnd = _checkOut;
    DateTime focusedDay = _checkIn ?? DateTime.now();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: 600,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColor.blanc,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Selectionnez les dates",
                        style: GoogleFonts.nunito(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColor.noir,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: TableCalendar(
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: focusedDay,
                      rangeStartDay: rangeStart,
                      rangeEndDay: rangeEnd,
                      calendarFormat: CalendarFormat.month,
                      rangeSelectionMode: RangeSelectionMode.toggledOn,
                      headerStyle: const HeaderStyle(
                        titleCentered: true,
                        formatButtonVisible: false,
                      ),
                      calendarStyle: CalendarStyle(
                        isTodayHighlighted: false,
                        rangeHighlightColor:
                            AppColor.dGreen.withValues(alpha: 0.2),
                        rangeStartDecoration: const BoxDecoration(
                          color: AppColor.dGreen,
                          shape: BoxShape.circle,
                        ),
                        rangeEndDecoration: const BoxDecoration(
                          color: AppColor.dGreen,
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: const BoxDecoration(
                          color: AppColor.dGreen,
                          shape: BoxShape.circle,
                        ),
                        // Style pour les dates désactivées (grisées)
                        disabledDecoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                      ),
                      // 🟢 Désactive toutes les dates avant aujourd'hui
                      enabledDayPredicate: (day) =>
                          !day.isBefore(DateTime.now()),
                      onRangeSelected: (start, end, focused) {
                        setModalState(() {
                          rangeStart = start;
                          rangeEnd = end;
                          focusedDay = focused;
                        });
                      },
                      onPageChanged: (focused) {
                        setModalState(() => focusedDay = focused);
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.dGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        if (rangeStart != null && rangeEnd != null) {
                          setState(() {
                            // Mettre à jour les deux dates (peu importe isCheckIn)
                            _checkIn = rangeStart;
                            _checkOut = rangeEnd;
                          });
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Veuillez sélectionner une plage de dates',
                              ),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Confirmez",
                        style: GoogleFonts.nunito(
                          color: AppColor.blanc,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
