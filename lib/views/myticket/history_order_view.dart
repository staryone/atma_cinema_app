import 'package:flutter/material.dart';

class HistoryOrderView extends StatefulWidget {
  const HistoryOrderView({super.key});

  @override
  State<HistoryOrderView> createState() => _HistoryOrderViewState();
}

class _HistoryOrderViewState extends State<HistoryOrderView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          Column(
            children: [
              Icon(
                Icons.movie,
                size: 80,
                color: Color(0xFF0A1D37),
              ),
              SizedBox(height: 20),
              Text(
                "Oops, History not Found!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Get exciting movie tickets, on the Atma Cinema',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(128, 28),
                  backgroundColor: Color(0xFF0A1D37),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'See a movie',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
