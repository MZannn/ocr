import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: AssetImage("assets/images/half_circle.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
              child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Riwayat Pengunjung",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    TableCalendar(
                      locale: 'id_ID',
                      focusedDay: DateTime.now(),
                      firstDay: DateTime(DateTime.now().year - 1,
                          DateTime.now().month, DateTime.now().day),
                      lastDay: DateTime.now(),
                      availableCalendarFormats: const {
                        CalendarFormat.month: 'Bulan',
                      },
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                        });
                      },
                      onPageChanged: (focusedDay) {
                        _selectedDay = focusedDay;
                      },
                      calendarFormat: _calendarFormat,
                      onFormatChanged: (format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      },
                    ),
                  ],
                ),
              )
            ],
          )),
        ],
      ),
    );
  }
}
