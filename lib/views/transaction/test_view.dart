import 'package:atma_cinema/utils/constants.dart';
import 'package:atma_cinema/views/transaction/movie_header.dart';
import 'package:atma_cinema/views/transaction/seat_view.dart';
import 'package:flutter/material.dart';
import 'package:atma_cinema/views/transaction/detail_movie_view.dart';
import 'package:atma_cinema/views/transaction/detail_schedule_view.dart';

class MovieTestPage extends StatefulWidget {
  @override
  _MovieTestPageState createState() => _MovieTestPageState();
}

class _MovieTestPageState extends State<MovieTestPage> {
  int selectedIndex = 0;
  int? selected2DTimeIndex;
  int? selected3DTimeIndex;

  final List<Map<String, String>> dates = [
    {'day': '12', 'label': 'Today'},
    {'day': '13', 'label': 'Sun'},
    {'day': '14', 'label': 'Mon'},
    {'day': '15', 'label': 'Tue'},
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              MovieHeader(
                title: 'Dilan 1990',
                genre: 'Drama, Romance',
                duration: '1 hour 20 minutes',
                director: 'Fajar Bustomi',
                rating: 3.5,
                backgroundImageUrl:
                    'https://m.media-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_SX300.jpg',
                posterImageUrl:
                    'https://m.media-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_SX300.jpg',
              ),
              const SizedBox(height: 20),
              TabBar(
                indicatorColor: Theme.of(context).primaryColor,
                indicatorWeight: 3,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(text: 'About Movie'),
                  Tab(text: 'Schedule'),
                ],
              ),
              SizedBox(
                height: 500,
                child: TabBarView(
                  children: [
                    DetailMovieView(),
                    DetailScheduleView(
                      dates: dates,
                      selectedIndex: selectedIndex,
                      onDateSelected: (index) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      selected2DTimeIndex: selected2DTimeIndex,
                      selected3DTimeIndex: selected3DTimeIndex,
                      on2DTimeSelected: (index) {
                        setState(() {
                          selected2DTimeIndex = index;
                        });
                      },
                      on3DTimeSelected: (index) {
                        setState(() {
                          selected3DTimeIndex = index;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          height: 70,
          padding: const EdgeInsets.all(16),
          color: colorPrimary,
          child: TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SeatSelectionScreen(),
                ),
              );
            },
            icon: const Icon(Icons.local_movies, color: Colors.white),
            label: const Text(
              'Buy Ticket',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
