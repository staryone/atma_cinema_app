import 'package:flutter/material.dart';

class DetailScheduleView extends StatefulWidget {
  final List<Map<String, String>> dates;
  final int selectedIndex;
  final ValueChanged<int> onDateSelected;
  final int? selected2DTimeIndex;
  final int? selected3DTimeIndex;
  final ValueChanged<int?> on2DTimeSelected;
  final ValueChanged<int?> on3DTimeSelected;

  const DetailScheduleView({
    Key? key,
    required this.dates,
    required this.selectedIndex,
    required this.onDateSelected,
    this.selected2DTimeIndex,
    this.selected3DTimeIndex,
    required this.on2DTimeSelected,
    required this.on3DTimeSelected,
  }) : super(key: key);

  @override
  State<DetailScheduleView> createState() => _DetailScheduleViewState();
}

class _DetailScheduleViewState extends State<DetailScheduleView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(widget.dates.length, (index) {
                final isSelected = index == widget.selectedIndex;
                return GestureDetector(
                  onTap: () {
                    widget.onDateSelected(index);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          widget.dates[index]['day']!,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.dates[index]['label']!,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 8),
            ScheduleSection(
              title: 'Reguler 2D',
              price: 'Rp 45.000',
              times: ['13.00', '15.00', '17.00', '19.00', '21.00'],
              selectedIndex: widget.selected2DTimeIndex,
              onTimeSelected: widget.on2DTimeSelected,
            ),
            const SizedBox(height: 16),
            ScheduleSection(
              title: 'Reguler 3D',
              price: 'Rp 40.000',
              times: ['13.00', '15.00', '17.00', '19.00', '21.00'],
              selectedIndex: widget.selected3DTimeIndex,
              onTimeSelected: widget.on3DTimeSelected,
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

  const ScheduleSection({
    Key? key,
    required this.title,
    required this.price,
    required this.times,
    this.selectedIndex,
    required this.onTimeSelected,
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
                final time = times[index];
                final isSelected = index == selectedIndex;
                return OutlinedButton(
                  onPressed: () => onTimeSelected(index),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.transparent,
                    side: const BorderSide(
                      color: Color.fromARGB(255, 150, 150, 150),
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
      ),
    );
  }
}
