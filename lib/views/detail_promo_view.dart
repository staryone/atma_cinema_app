import 'package:flutter/material.dart';

class DetailPromoView extends StatefulWidget {
  final String promoImageUrl;

  const DetailPromoView({super.key, required this.promoImageUrl});

  @override
  State<DetailPromoView> createState() => _DetailPromoViewState();
}

class _DetailPromoViewState extends State<DetailPromoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('National Popcorn Day Promo'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menampilkan gambar promo yang diterima dari HomeView
            Image.network(
              widget.promoImageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Popcorn National Day Promo - Terms & Conditions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '1. Promo Period: The promotion is valid from 01 January - 12 January 2025\n'
              '2. Eligibility: The offer is available to all customers purchasing at participating stores or online during the promo period.\n'
              '3. Offer Details:\n'
              '   • Buy any large popcorn and get a second large popcorn for free.\n'
              '   • The offer applies to the same flavor only.\n'
              '4. Availability: The promotion is available while stocks last.\n'
              '5. Limitations:\n'
              '   • One offer per customer per transaction.\n'
              '   • The offer cannot be combined with any other discounts or promotions.\n'
              '6. Non-transferable: The promo is non-transferable and cannot be exchanged for cash or any other products.\n'
              '7. Changes: The company reserves the right to modify or cancel the promotion at any time without prior notice.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
