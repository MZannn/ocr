import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ocr_visitor/cubit/history/history_cubit.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  // DateTime? _selectedDay;
  // CalendarFormat _calendarFormat = CalendarFormat.month;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoaded) {
            return Stack(
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
                        children: state.histories
                            .map((e) => Card(
                                  child: ListTile(
                                    title: Text(e.name!),
                                    subtitle: Text(
                                        "Berkunjung ke rumah ${e.personToVisit} pada ${DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(
                                      e.date!,
                                    )}"),
                                  ),
                                ))
                            .toList(),
                      ),
                    )
                  ],
                )),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
