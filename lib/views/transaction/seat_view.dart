import 'package:atma_cinema/components/screen_area_component.dart';
import 'package:atma_cinema/utils/constants.dart';
import 'package:flutter/material.dart';

class SeatSelectionScreen extends StatefulWidget {
  const SeatSelectionScreen({Key? key}) : super(key: key);
  @override
  _SeatSelectionScreenState createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  List<Map<String, dynamic>> seatData = [
    {'id': 'A10', 'status': 'available'},
    {'id': 'A11', 'status': 'available'},
    {'id': 'A12', 'status': 'booked'},
    {'id': 'A13', 'status': 'available'},
    {'id': 'A14', 'status': 'available'},
    {'id': 'B10', 'status': 'available'},
    {'id': 'B11', 'status': 'booked'},
    {'id': 'B12', 'status': 'booked'},
    {'id': 'B13', 'status': 'available'},
    {'id': 'B14', 'status': 'available'},
    {'id': 'B15', 'status': 'available'},
  ];

  List<String> selectedSeats = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Schedule',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sat, 12.10.2021 | ', style: TextStyle(fontSize: 14)),
                Text('13.00 | Reguler', style: TextStyle(fontSize: 14)),
              ],
            )
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Header
          Expanded(
            child: InteractiveViewer(
              panEnabled: true,
              minScale: 0.5,
              maxScale: 3.0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 32, bottom: 32),
                      height: 80,
                      width: 500,
                      child: ScreenArea(),
                    ),
                    SizedBox(
                      height: 500,
                      width: 600,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: GridView.builder(
                          shrinkWrap: false,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 8,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 10,
                          ),
                          itemCount: seatData.length,
                          itemBuilder: (context, index) {
                            final seat = seatData[index];
                            final isAvailable = seat['status'] == 'available';
                            final isBooked = seat['status'] == 'booked';
                            final isSelected =
                                selectedSeats.contains(seat['id']);

                            return GestureDetector(
                              onTap: isAvailable
                                  ? () {
                                      setState(() {
                                        if (isSelected) {
                                          selectedSeats.remove(seat['id']);
                                        } else {
                                          selectedSeats.add(seat['id']);
                                        }
                                      });
                                    }
                                  : null,
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? colorGold
                                      : isBooked
                                          ? colorPrimary
                                          : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(
                                  seat['id'],
                                  style: TextStyle(
                                    color: isAvailable || isSelected
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Available
                _buildLegendItem(Colors.grey[300]!, 'Available'),
                const SizedBox(width: 16),
                // Booked
                _buildLegendItem(colorPrimary!, 'Booked'),
                const SizedBox(width: 16),
                // Selected
                _buildLegendItem(colorGold, 'Selected'),
              ],
            ),
          ),
          // Footer
          Container(
            padding: const EdgeInsets.all(16.0),
            color: colorPrimary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedSeats.isNotEmpty
                          ? '${selectedSeats.length} seat(s) picked'
                          : 'No seats selected',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Rp ${selectedSeats.length * 45000}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          selectedSeats.clear();
                        });
                      },
                      child: const Text('Clear picks'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorGold,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: selectedSeats.isNotEmpty
                          ? () {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('Booking Confirmed'),
                                  content: Text(
                                      'You have selected: ${selectedSeats.join(', ')}'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          : null,
                      child: const Text('Continue'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
