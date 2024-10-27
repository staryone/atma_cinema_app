import 'package:atma_cinema/utils/constants.dart';
import 'package:flutter/material.dart';

class MyTicketView extends StatefulWidget {
  @override
  _MyTicketViewState createState() => _MyTicketViewState();
}

class _MyTicketViewState extends State<MyTicketView> {
  bool isActiveOrdersSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 45.0),
          child: Text(
            'My Ticket',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto",
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isActiveOrdersSelected = true;
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          'Active orders',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isActiveOrdersSelected
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                        if (isActiveOrdersSelected)
                          Container(
                            height: 2,
                            width: 150,
                            color: colorPrimary,
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isActiveOrdersSelected = false;
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          'History orders',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: !isActiveOrdersSelected
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                        if (!isActiveOrdersSelected)
                          Container(
                            height: 2,
                            width: 150,
                            color: Colors.black,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Icon(
              Icons.movie,
              size: 80,
              color: Color(0xFF0A1D37),
            ),
            SizedBox(height: 20),
            Text(
              "Let's watch a movie!",
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
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyTicketView(),
  ));
}
