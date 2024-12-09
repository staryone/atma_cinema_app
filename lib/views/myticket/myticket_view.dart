import 'package:atma_cinema/utils/constants.dart';
import 'package:atma_cinema/views/myticket/active_order_view.dart';
import 'package:atma_cinema/views/myticket/detail_ticket_view.dart';
import 'package:atma_cinema/views/myticket/history_order_view.dart';
import 'package:flutter/material.dart';

class MyTicketView extends StatefulWidget {
  @override
  _MyTicketViewState createState() => _MyTicketViewState();
}

class _MyTicketViewState extends State<MyTicketView> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      ActiveOrderView(),
      HistoryOrderView(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 90,
        title: Padding(
          padding: const EdgeInsets.only(top: 45, bottom: 20),
          child: Text(
            'My Ticket',
            style: styleHeade2,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _onItemTapped(0);
                    },
                    child: Column(
                      children: [
                        Text(
                          'Active orders',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _selectedIndex == 0
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                        if (_selectedIndex == 0)
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
                      _onItemTapped(1);
                    },
                    child: Column(
                      children: [
                        Text(
                          'History orders',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _selectedIndex == 1
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                        if (_selectedIndex == 1)
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
            SizedBox(height: 20),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                children: _widgetOptions,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
