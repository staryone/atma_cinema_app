import 'package:atma_cinema/models/promo_model.dart';
import 'package:atma_cinema/utils/constants.dart';
import 'package:flutter/material.dart';

class DetailPromoView extends StatefulWidget {
  final PromoModel promo;

  const DetailPromoView({super.key, required this.promo});

  @override
  State<DetailPromoView> createState() => _DetailPromoViewState();
}

class _DetailPromoViewState extends State<DetailPromoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.promo.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: colorPrimary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.promo.pathImage ?? '',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
            const SizedBox(height: 16.0),
            Text(
              widget.promo.name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.promo.description ?? '',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
