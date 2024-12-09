import 'dart:io';

import 'package:atma_cinema/models/screening_model.dart';
import 'package:atma_cinema/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:atma_cinema/providers/screening_provider.dart';

class DetailScheduleView extends ConsumerStatefulWidget {
  final int selectedDateIndex;
  final ValueChanged<int> onDateSelected;
  final ScreeningModel? selectedScreening;
  final ValueChanged<ScreeningModel?> onScreeningSelected;
  final String movieID;

  const DetailScheduleView({
    Key? key,
    required this.selectedDateIndex,
    required this.onDateSelected,
    this.selectedScreening,
    required this.onScreeningSelected,
    required this.movieID,
  }) : super(key: key);

  @override
  ConsumerState<DetailScheduleView> createState() => _DetailScheduleViewState();
}

class _DetailScheduleViewState extends ConsumerState<DetailScheduleView> {
  late List<Map<String, String>> dates;

  @override
  void initState() {
    super.initState();
    dates = _generateDates();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(movieIDProvider.notifier).state = widget.movieID;
    });
  }

  List<Map<String, String>> _generateDates() {
    List<Map<String, String>> dateList = [];
    DateTime now = DateTime.now();

    for (int i = 0; i < 5; i++) {
      DateTime date = now.add(Duration(days: i));
      dateList.add({
        'day': DateFormat('d').format(date),
        'label': i == 0 ? 'Today' : DateFormat('EEE').format(date),
        'date': DateFormat('yyyy-MM-dd').format(date),
        'time': DateFormat('HH:mm:ss').format(DateTime.now()),
      });
    }

    return dateList;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date Selector
          SizedBox(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dates.length,
              itemBuilder: (context, index) {
                final isSelected = index == widget.selectedDateIndex;
                final isToday = index == 0;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 80,
                  child: GestureDetector(
                    onTap: isToday
                        ? () {
                            widget.onDateSelected(index);
                          }
                        : null,
                    child: Opacity(
                      opacity: isToday ? 1.0 : 0.5,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isToday
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade400,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              dates[index]['day']!,
                              style: TextStyle(
                                color: isToday
                                    ? (isSelected ? Colors.white : Colors.black)
                                    : Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              dates[index]['label']!,
                              style: TextStyle(
                                color: isToday
                                    ? (isSelected ? Colors.white : Colors.black)
                                    : Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // Schedule Sections
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final screeningsAsyncValue =
                    ref.watch(screeningsFetchByMovieProvider);
                return screeningsAsyncValue.when(
                    data: (screenings) {
                      // Filter screenings by selected date
                      final selectedDate =
                          dates[widget.selectedDateIndex]['date'];
                      final selectedTime = DateFormat('HH:mm:ss')
                          .parse(dates[widget.selectedDateIndex]['time'] ?? '');
                      // screenings.map((screening) => print(screening));
                      final filteredScreenings = screenings
                          .where((screening) =>
                              screening.date ==
                                  DateTime.parse(selectedDate ?? '') &&
                              selectedTime.isBefore(
                                  DateFormat('HH:mm:ss').parse(screening.time)))
                          .toList();
                      // print(filteredScreenings);

                      // Group screenings by studio
                      final Map<String, List<ScreeningModel>>
                          screeningsByStudio = {};
                      for (var screening in filteredScreenings) {
                        screeningsByStudio
                            .putIfAbsent(screening.studio.name, () => [])
                            .add(screening);
                      }

                      List<Widget> scheduleSections = [];
                      for (String studioName in [
                        'Reguler 2D',
                        'Reguler 3D',
                        'Premier 2D',
                        'Premier 3D'
                      ]) {
                        final screeningsList =
                            screeningsByStudio[studioName] ?? [];
                        if (screeningsList.isNotEmpty) {
                          scheduleSections.add(
                            ScheduleSection(
                              title: studioName,
                              price:
                                  "Rp${screeningsByStudio[studioName]!.first.price.toString()}",
                              screenings: screeningsList,
                              selectedScreening: widget.selectedScreening,
                              onTimeSelected: (screening) {
                                widget.onScreeningSelected(screening);
                              },
                              color: studioName.startsWith('Premier')
                                  ? const Color(0xFFF3E9D3)
                                  : const Color.fromARGB(255, 239, 238, 238),
                            ),
                          );
                          scheduleSections.add(const SizedBox(height: 16));
                        }
                      }
                      
                      return SingleChildScrollView(
                        child: Column(
                          children: scheduleSections,
                        ),
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (err, stack) {
                      String message;

                      if (err is HttpException) {
                        message = err.message;
                      } else if (err is Exception) {
                        message = err
                            .toString()
                            .replaceFirst(RegExp(r'^Exception: '), '');
                      } else {
                        message = 'Terjadi kesalahan yang tidak diketahui';
                      }

                      return Center(child: Text(message));
                    });
              },
            ),
          ),
        ],
      ),
    );
  }

  // String getPriceForStudio(String studioName) {
  //   switch (studioName) {
  //     case 'Reguler 2D':
  //       return 'Rp 40.000';
  //     case 'Reguler 3D':
  //       return 'Rp 45.000';
  //     case 'Premier 2D':
  //       return 'Rp 70.000';
  //     case 'Premier 3D':
  //       return 'Rp 80.000';
  //     default:
  //       return '';
  //   }
  // }
}

class ScheduleSection extends StatelessWidget {
  final String title;
  final String price;
  final List<ScreeningModel> screenings;
  final ScreeningModel? selectedScreening;
  final ValueChanged<ScreeningModel?> onTimeSelected;
  final Color color;

  const ScheduleSection({
    Key? key,
    required this.title,
    required this.price,
    required this.screenings,
    this.selectedScreening,
    required this.onTimeSelected,
    this.color = const Color.fromARGB(255, 239, 238, 238),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: $price',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.5,
            ),
            itemCount: screenings.length,
            itemBuilder: (context, index) {
              final screening = screenings[index];
              final time = screening.time.substring(0, 5);
              final isSelected = screening == selectedScreening;

              return OutlinedButton(
                onPressed: () => onTimeSelected(screening),
                style: OutlinedButton.styleFrom(
                  backgroundColor: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.transparent,
                  side: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                child: Text(
                  time,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
