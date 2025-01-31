import 'dart:convert';

import 'package:atma_cinema/clients/payment_client.dart';
import 'package:atma_cinema/components/screen_area_component.dart';
import 'package:atma_cinema/models/payment_model.dart';
import 'package:atma_cinema/models/screening_model.dart';
import 'package:atma_cinema/providers/screening_provider.dart';
import 'package:atma_cinema/utils/constants.dart';
import 'package:atma_cinema/views/transaction/payment/confirm_payment_view.dart';
import 'package:atma_cinema/views/transaction/payment/payment_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class SeatSelectionScreen extends ConsumerStatefulWidget {
  final ScreeningModel screening;
  const SeatSelectionScreen({super.key, required this.screening});
  @override
  ConsumerState<SeatSelectionScreen> createState() =>
      _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends ConsumerState<SeatSelectionScreen> {
  List<String> selectedSeats = [];
  late String formattedDate;
  late String formattedTime;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(screeningIDProvider.notifier).state =
          widget.screening.screeningID;
    });

    // seatData = widget.screening.seatLayout.entries
    //     .map((entry) => {'id': entry.key, 'status': entry.value})
    //     .toList();
    formattedDate = DateFormat('EEE, dd.MM.yyyy').format(widget.screening.date);

    DateTime fullTime = DateTime.parse("2024-12-08 ${widget.screening.time}");
    formattedTime = DateFormat('HH.mm').format(fullTime);
  }

  @override
  Widget build(BuildContext context) {
    final screeningAsync = ref.watch(screeningsFetchByIdProvider);
    return Scaffold(
        backgroundColor: Colors.white,
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
                  Text('$formattedDate | ', style: TextStyle(fontSize: 14)),
                  Text('$formattedTime | ${widget.screening.studio.name}',
                      style: TextStyle(fontSize: 14)),
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
        body: screeningAsync.when(
            data: (screening) {
              final seatData = screening.seatLayout.entries
                  .map((entry) => {'id': entry.key, 'status': entry.value})
                  .toList();

              return Column(
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
                              margin:
                                  const EdgeInsets.only(top: 32, bottom: 32),
                              height: 80,
                              width: 500,
                              child: ScreenArea(),
                            ),
                            SizedBox(
                              height: 500,
                              width: 600,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: GridView.builder(
                                  shrinkWrap: false,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 8,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 10,
                                  ),
                                  itemCount: seatData.length,
                                  itemBuilder: (context, index) {
                                    final seat = seatData[index];
                                    final isAvailable =
                                        seat['status'] == 'available';
                                    final isBooked = seat['status'] == 'booked';
                                    final isSelected =
                                        selectedSeats.contains(seat['id']);

                                    return GestureDetector(
                                      onTap: isAvailable
                                          ? () {
                                              setState(() {
                                                if (isSelected) {
                                                  selectedSeats
                                                      .remove(seat['id']);
                                                } else {
                                                  if (selectedSeats.length >=
                                                      3) {
                                                    showOverlayWarning(context,
                                                        'You can only pick up to 3 seats.');
                                                  } else {
                                                    selectedSeats
                                                        .add(seat['id']);
                                                  }
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
                                          borderRadius:
                                              BorderRadius.circular(4.0),
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
                              'Rp ${selectedSeats.length * widget.screening.price}',
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
                                  ? () async {
                                      setState(() => _isLoading = true);

                                      try {
                                        final paymentData = {
                                          'screeningID': screening.screeningID,
                                          'paymentMethod': 'BCA',
                                          'paymentStatus': 'pending',
                                          'paymentDate':
                                              DateFormat('yyyy-MM-dd')
                                                  .format(DateTime.now()),
                                          'totalPayment':
                                              widget.screening.price *
                                                  selectedSeats.length,
                                        };

                                        final paymentClient = PaymentClient();
                                        final paymentResult =
                                            await paymentClient
                                                .createPayment(paymentData);

                                        setState(() => _isLoading = false);
                                        final paymentDataFinal =
                                            PaymentModel.fromJson(
                                                paymentResult['data']);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ConfirmPaymentPage(
                                              paymentData: paymentDataFinal,
                                              seatNumber: selectedSeats,
                                            ),
                                          ),
                                        );
                                      } catch (e) {
                                        setState(() => _isLoading = false);
                                        showOverlayWarning(context,
                                            'Failed to create payment: $e');
                                      }
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
              );
            },
            error: (err, _) => Center(child: Text('No seat found')),
            loading: () => const Center(child: CircularProgressIndicator())));
  }

  void showOverlayWarning(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50,
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
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
