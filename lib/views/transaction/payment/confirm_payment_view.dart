import 'dart:async';
import 'package:atma_cinema/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:atma_cinema/views/transaction/payment/payment_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConfirmPaymentPage(),
    );
  }
}

class ConfirmPaymentPage extends StatefulWidget {
  @override
  _ConfirmPaymentPageState createState() => _ConfirmPaymentPageState();
}

class _ConfirmPaymentPageState extends State<ConfirmPaymentPage> {
  Duration remainingTime = Duration(minutes: 9, seconds: 31);
  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime.inSeconds > 0) {
        setState(() {
          remainingTime -= Duration(seconds: 1);
        });
      } else {
        timer.cancel();
        // Tindakan jika waktu habis
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Time is up! Please restart payment.")),
        );
      }
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$minutes:$seconds";
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: const Text(
          "Payment",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Informasi tiket
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 70,
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://i.pinimg.com/564x/a4/9d/c8/a49dc85d98d25389f9d939bbd8663e43.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Dilan 1990",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Saturday, 12 Oct 2021, 13:00",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 9),
                              overflow: TextOverflow
                                  .visible, // Pastikan teks tetap tampil seluruhnya
                            ),
                            SizedBox(height: 4),
                            Text(
                              "A9",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "1 Tickets",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 80.0),
                        child: Text(
                          "Rp45.000  x  1",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                    indent: 0, // Hapus indent
                    endIndent: 0, // Hapus endIndent
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "TOTAL",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Rp45.000",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Tax Include",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Total dan Timer
            Stack(
              children: [
                // Container untuk informasi Total dan Payment ID
                Container(
                  padding:
                      EdgeInsets.all(16), // Memberikan padding di dalam kotak
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(12), // Sudut yang melengkung
                    border: Border.all(
                        color: Colors.grey.shade300), // Border abu-abu
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Kolom untuk bagian Total dan Payment ID di sebelah kiri
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Rp45.000",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          // Kolom untuk harga
                          Text(
                            "Payment ID: PV3427JK",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: RichText(
                    text: TextSpan(
                      text: "Select in: ", // Bagian teks pertama
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey, // Warna abu-abu
                      ),
                      children: [
                        TextSpan(
                          text: formatDuration(remainingTime), // Bagian waktu
                          style: const TextStyle(
                            color: Colors.red, // Warna merah untuk waktu
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),
            Text(
              "Choose Payment Method",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[500]),
            ),
            SizedBox(height: 16),
            Text(
              "Transfer Bank",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(
                  left: 0), // Memberikan padding kiri dan kanan
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.start, // Menyusun kotak dari kiri
                children: [
                  _buildBankIcon("images/bca_logo.png"),
                  SizedBox(width: 8), // Menambahkan jarak antar kotak
                  _buildBankIcon("images/mandiri_logo.png"),
                  SizedBox(width: 8),
                  _buildBankIcon("images/bri_logo.png"),
                  SizedBox(width: 8),
                  _buildBankIcon("images/bni_logo.png"),
                ],
              ),
            ),

            SizedBox(height: 16),
            Text(
              "Credit Card / Debit",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(
                  left: 0), // Memberikan padding kiri dan kanan
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.start, // Menyusun kotak dari kiri
                children: [
                  _buildBankIcon("images/visa_logo.png"),
                  SizedBox(width: 8), // Menambahkan jarak antar kotak
                  _buildBankIcon("images/permata_logo.png"),
                  SizedBox(width: 8),
                  _buildBankIcon("images/jcb_logo.png"),
                  SizedBox(width: 8),
                  _buildBankIcon("images/master_logo.png"),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBankIcon(String imagePath) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke PaymentView
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PaymentView()),
        );
      },
      child: Container(
        width: 58,
        height: 37,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Center(
          child: Image.asset(
            imagePath,
            width: 45,
            height: 30,
          ),
        ),
      ),
    );
  }
}
