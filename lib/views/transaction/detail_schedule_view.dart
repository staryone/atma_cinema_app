import 'package:flutter/material.dart';

class ScheduleTabView extends StatelessWidget {
  const ScheduleTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Date Tabs Section
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildDateTab("12", "Today", isSelected: true),
              _buildDateTab("13", "Sun"),
              _buildDateTab("14", "Mon"),
              _buildDateTab("15", "Tue"),
            ],
          ),
        ),
        const Divider(),
        // Schedule Details
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildScheduleSection(
                title: "Regular 2D",
                price: "Rp 45.000",
                times: ["13.00", "15.00", "17.00", "19.00", "21.00"],
              ),
              const SizedBox(height: 16),
              _buildScheduleSection(
                title: "Regular 3D",
                price: "Rp 40.000",
                times: ["13.00", "15.00", "17.00", "19.00", "21.00"],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget for building individual schedule sections
  Widget _buildScheduleSection({
    required String title,
    required String price,
    required List<String> times,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title: $price",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: times.map((time) {
              return _buildTimeButton(time);
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Widget for building time buttons
  Widget _buildTimeButton(String time) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black,
        side: const BorderSide(color: Colors.blue),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: time == "13.00" ? Colors.blue : Colors.white,
      ),
      child: Text(
        time,
        style: TextStyle(
          color: time == "13.00" ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Widget for building individual date tabs
  Widget _buildDateTab(String day, String label, {bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blue : Colors.white,
          foregroundColor: isSelected ? Colors.white : Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: isSelected ? Colors.blue : Colors.grey,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              day,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
