import 'package:flutter/material.dart';
import 'package:atma_cinema/utils/constants.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: const Text(
          "About Us",
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
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'images/backgroudAppBar.jpeg',
                  height: 240,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Tentang Kami",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto',
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Atma Cinema, adalah perusahaan teknologi dari mahasiswa Universitas Atma Jaya Yogyakarta yang berbasis platform, dengan membawa misi memajukan teknologi digital dalam penjualan tiket bioskop.",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        "Atma Cinema adalah platform yang memiliki Ticketing Management Service (TMS) teknologi unggul dalam mendukung pembelian tiket bioskop secara online melalui aplikasi atma cinema untuk memudahkan pengguna melakukan pembelian.",
                        style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Beberapa teknologi yang kami sediakan untuk atma cinema adalah untuk memfasilitasi pembelian tiket bioskop secara online:",
                        style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        " • Distributor tiket online yang telah bekerja sama dengan rumah produksi film untuk menjual tiket untuk anda.\n\n"
                        " • Sistem pembayaran yang beragam dan aman untuk memberikan kemudahan kepada calon pembeli, untuk mendapat konversi yang lebih tinggi.\n\n"
                        " • Mencatat history transaksi dan memberikan analisis rating film untuk memudahkan pengguna memilih film yang ingin ditonton.",
                        style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
