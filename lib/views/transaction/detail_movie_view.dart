import 'package:flutter/material.dart';

class PrivacyView extends StatelessWidget {
  const PrivacyView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> castImages = [
      "images/download.jpeg",
      "images/download.jpeg",
      "images/download.jpeg",
      "images/download.jpeg",
      "images/download.jpeg",
      "images/download.jpeg",
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Dilan 1990",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Dilan 1990 is a romantic drama film adapted from a novel by Pidi Baiq. Set in Bandung in 1990, the film tells the love story of two teenagers, Dilan, a charismatic high school student, and Milea, a transfer student from Jakarta. Starring Iqbaal Ramadhan and Vanesha Prescilla, the film captivated audiences with its light, romantic, and nostalgic dialogue.",
              style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
            ),
            const SizedBox(height: 16),
            const Text(
              "Producer",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            const Text(
              "Ody Mulya Hidayat",
              style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
            ),
            const SizedBox(height: 8),
            const Text(
              "Director",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            const Text(
              "Fajar Bustomi, Pidi Baiq",
              style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
            ),
            const SizedBox(height: 8),
            const Text(
              "Writers",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            const Text(
              "Pidi Baiq, Titien Wattimena",
              style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
            ),
            const SizedBox(height: 16),
            const Text(
              "Cast",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: castImages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      width: 90,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(castImages[index]),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
