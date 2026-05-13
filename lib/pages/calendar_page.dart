import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../widgets/app_bar.dart';
import 'booking_summary_page.dart';
import '../constants.dart';
import '../models/hotel_model.dart';
import 'package:get/get.dart';

final DateTime kNow = DateTime.now();
final DateTime kFirstDay = DateTime(kNow.year, kNow.month - 3, kNow.day);
final DateTime kLastDay = DateTime(kNow.year, kNow.month + 3, kNow.day);

class CalendarPage extends StatelessWidget {
  final Hotel hotel;

  const CalendarPage({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Calendar'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const PeriodSection(),
            CalendarRange(hotel: hotel),
          ],
        ),
      ),
    );
  }
}

class PeriodSection extends StatelessWidget {
  const PeriodSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text('Départ', style: TextStyle(color: Colors.grey[700])),
                const Text(
                  '12 Dec',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            Container(height: 40, width: 1, color: Colors.grey[350]),
            Column(
              children: [
                Text('Retour', style: TextStyle(color: Colors.grey[700])),
                const Text(
                  '22 Dec',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ],
        ),
        const Divider(height: 30),
      ],
    );
  }
}

class CalendarRange extends StatefulWidget {
  final Hotel hotel;

  const CalendarRange({super.key, required this.hotel});

  @override
  State<CalendarRange> createState() => _CalendarRangeState();
}

class _CalendarRangeState extends State<CalendarRange> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          firstDay: kFirstDay,
          lastDay: kLastDay,
          focusedDay: _focusedDay,
          rangeStartDay: _rangeStart,
          rangeEndDay: _rangeEnd,
          calendarFormat: _calendarFormat,
          rangeSelectionMode: RangeSelectionMode.toggledOn,
          headerStyle: const HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
          ),
          calendarStyle: const CalendarStyle(
            isTodayHighlighted: false,
            rangeHighlightColor: dGreen,
            rangeStartDecoration: BoxDecoration(
              color: dGreen,
              shape: BoxShape.circle,
            ),
            rangeEndDecoration: BoxDecoration(
              color: dGreen,
              shape: BoxShape.circle,
            ),
          ),
          onRangeSelected: (start, end, focusedDay) {
            setState(() {
              _focusedDay = focusedDay;
              _rangeStart = start;
              _rangeEnd = end;
            });
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
        ),
        const ListTile(
          leading: Icon(Icons.event_repeat, color: dGreen),
          title: Text('Flexible with dates'),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: dGreen,
              padding: const EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              if (_rangeStart != null && _rangeEnd != null) {
                Get.to(
                  BookingSummaryPage(
                    hotel: widget.hotel,
                    start: _rangeStart!,
                    end: _rangeEnd!,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sélectionnez une période')),
                );
              }
            },
            child: const Text(
              'Apply',
              style: TextStyle(fontSize: 17, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
