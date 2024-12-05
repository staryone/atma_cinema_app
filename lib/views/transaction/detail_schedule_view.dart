import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:atma_cinema/providers/screening_provider.dart';

class DetailScheduleView extends ConsumerStatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onDateSelected;
  final int? selected2DTimeIndex;
  final int? selected3DTimeIndex;
  final ValueChanged<int?> on2DTimeSelected;
  final ValueChanged<int?> on3DTimeSelected;
  final String movieID;

  const DetailScheduleView(
      {Key? key,
      required this.selectedIndex,
      required this.onDateSelected,
      this.selected2DTimeIndex,
      this.selected3DTimeIndex,
      required this.on2DTimeSelected,
      required this.on3DTimeSelected,
      required this.movieID})
      : super(key: key);

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
      });
    }

    return dateList;
  }

  @override
  Widget build(BuildContext context) {
    // ref.read(movieIDProvider.notifier).state = widget.movieID;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(dates.length, (index) {
                  final isSelected = index == widget.selectedIndex;
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
                  );
                }),
              ),
            ),
            const SizedBox(height: 8),
            // Jadwal 2D
            Consumer(
              builder: (context, ref, child) {
                final screeningsAsyncValue =
                    ref.watch(screeningsFetchByMovieProvider);
                return screeningsAsyncValue.when(
                  data: (screenings) {
                    final availableTimes = screenings
                        // .where((screening) =>
                        //     screening.date ==
                        //     dates[widget.selectedIndex]['date'])
                        .map((screening) => screening.time)
                        .toSet();

                    return ScheduleSection(
                      title: 'Reguler 2D',
                      price: 'Rp 45.000',
                      times: ['13.00', '15.00', '17.00', '19.00', '21.00'],
                      selectedIndex: widget.selected2DTimeIndex,
                      onTimeSelected: widget.on2DTimeSelected,
                      availableTimes: availableTimes,
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Center(child: Text('Error: $err')),
                );
              },
            ),
            const SizedBox(height: 16),
            // Jadwal 3D (contoh mirip 2D)
            ScheduleSection(
              title: 'Reguler 3D',
              price: 'Rp 40.000',
              times: ['13.00', '15.00', '17.00', '19.00', '21.00'],
              selectedIndex: widget.selected3DTimeIndex,
              onTimeSelected: widget.on3DTimeSelected,
              availableTimes: const {},
            ),
          ],
        ),
      ),
    );
  }
}

class ScheduleSection extends StatelessWidget {
  final String title;
  final String price;
  final List<String> times;
  final int? selectedIndex;
  final ValueChanged<int?> onTimeSelected;
  final Set<String> availableTimes;

  const ScheduleSection({
    Key? key,
    required this.title,
    required this.price,
    required this.times,
    this.selectedIndex,
    required this.onTimeSelected,
    required this.availableTimes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 247, 247, 247),
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
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2.5,
              ),
              itemCount: times.length,
              itemBuilder: (context, index) {
                final formattedTimes = times.map((time) {
                  final parts = time.split('.');
                  final hours = parts[0].padLeft(2, '0');
                  final minutes = parts[1].padRight(2, '0');
                  return '$hours:$minutes:00';
                }).toList();
                final time = formattedTimes[index];
                // print(times);
                final isAvailable = availableTimes.contains(time);
                print(availableTimes);
                final isSelected = index == selectedIndex;

                return OutlinedButton(
                  onPressed: isAvailable ? () => onTimeSelected(index) : null,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.transparent,
                    side: BorderSide(
                      color: isAvailable
                          ? (isSelected
                              ? Theme.of(context).primaryColor
                              : const Color.fromARGB(255, 150, 150, 150))
                          : Colors.grey,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  child: Text(
                    time,
                    style: TextStyle(
                      color: isAvailable
                          ? (isSelected
                              ? Colors.white
                              : Theme.of(context).primaryColor)
                          : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
