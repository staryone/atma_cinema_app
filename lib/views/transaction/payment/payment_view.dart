import 'dart:async';
import 'package:atma_cinema/clients/history_client.dart';
import 'package:atma_cinema/clients/payment_client.dart';
import 'package:atma_cinema/clients/screening_client.dart';
import 'package:atma_cinema/clients/ticket_client.dart';
import 'package:atma_cinema/models/payment_model.dart';
import 'package:atma_cinema/providers/history_provider.dart';
import 'package:atma_cinema/providers/screening_provider.dart';
import 'package:atma_cinema/providers/ticket_provider.dart';
import 'package:atma_cinema/views/transaction/payment/success_payment_view.dart';
import 'package:flutter/material.dart';
import 'package:atma_cinema/utils/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentView extends ConsumerStatefulWidget {
  final PaymentModel paymentData;
  final Duration duration;
  final List<String> seatNumber;
  const PaymentView(
      {super.key,
      required this.paymentData,
      required this.duration,
      required this.seatNumber});

  @override
  ConsumerState<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends ConsumerState<PaymentView> {
  late Duration duration; // Waktu awal
  Timer? timer;

  final TicketClient _ticketClient = TicketClient();
  final HistoryClient _historyClient = HistoryClient();
  final PaymentClient _paymentClient = PaymentClient();
  final ScreeningClient _screeningClient = ScreeningClient();

  @override
  void initState() {
    super.initState();
    duration = widget.duration;
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (duration.inSeconds > 0) {
        setState(() {
          duration -= const Duration(seconds: 1);
        });
      } else {
        timer?.cancel();
      }
    });
  }

  String formatDuration(Duration d) {
    String minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "${d.inHours.toString().padLeft(2, '0')}:$minutes:$seconds";
  }

  Future<void> _handleCheckStatus() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      for (String seat in widget.seatNumber) {
        await _ticketClient.createTicket({
          'paymentID': widget.paymentData.paymentID,
          'seatID': seat,
          'status': 'Success',
        });
      }

      final historyData = {
        'paymentID': widget.paymentData.paymentID,
      };
      await _historyClient.createHistory(historyData);

      const paymentStatus = 'completed';
      await _paymentClient.editStatusPayment(
          widget.paymentData.paymentID, paymentStatus);

      await _screeningClient.updateSeatLayout(
          widget.paymentData.screening.screeningID,
          widget.seatNumber,
          "booked");

      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment status updated successfully!')),
      );

      ref.invalidate(ticketsFetchActiveProvider);
      ref.invalidate(historysFetchActiveProvider);
      ref.invalidate(screeningsFetchByMovieProvider);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => PaymentSuccessView(
            paymentData: widget.paymentData,
          ),
        ),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: colorPrimary,
        title: Text(
          widget.paymentData.user.fullName,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFF5F7F9),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2.0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Rp45.000",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              "Payment ID: ${widget.paymentData.paymentID}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.copy,
                              size: 16,
                              color: Colors.blue[900],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text(
                        "Details ▾",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Countdown Timer
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Pay within ",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                formatDuration(duration),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Bank BCA",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Complete payment from BCA to the virtual account\nnumber below.",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Image.asset(
                            "images/bca_logo.png",
                            width: 50,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Virtual account number",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "52328432992832",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        label: const Text(
                          "Copy",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 10),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.info, size: 16, color: Colors.black),
                    label: const Text(
                      "How to pay ▾",
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    style: TextButton.styleFrom(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white,
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colorPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: _handleCheckStatus,
            child: const Text(
              "Check status",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
