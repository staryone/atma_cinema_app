import 'package:atma_cinema/utils/constants.dart';
import 'package:atma_cinema/views/fnb_view.dart';
import 'package:atma_cinema/views/myticket_view.dart';
import 'package:flutter/material.dart';
import 'package:atma_cinema/views/home_view.dart';
// import 'package:guidedlayout2_2140/View/view_list.dart';

class DashboardView extends StatefulWidget {
  final Map? data;
  const DashboardView({super.key, this.data});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    MyticketView(),
    FnbView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        child: BottomNavigationBar(
          selectedItemColor: colorPrimary,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_rounded,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.local_activity,
                ),
                label: 'Ticket'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.fastfood,
                ),
                label: 'FnB'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
