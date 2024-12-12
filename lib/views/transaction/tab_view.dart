import 'package:atma_cinema/models/movie_model.dart';
import 'package:atma_cinema/models/screening_model.dart';
import 'package:atma_cinema/utils/constants.dart';
import 'package:atma_cinema/utils/time_utils.dart';
import 'package:atma_cinema/views/transaction/movie_header.dart';
import 'package:atma_cinema/views/transaction/seat_view.dart';
import 'package:flutter/material.dart';
import 'package:atma_cinema/views/transaction/detail_movie_view.dart';
import 'package:atma_cinema/views/transaction/detail_schedule_view.dart';

class MovieTabPage extends StatefulWidget {
  final MovieModel dataMovie;

  const MovieTabPage({super.key, required this.dataMovie});

  @override
  _MovieTabPageState createState() => _MovieTabPageState();
}

class _MovieTabPageState extends State<MovieTabPage>
    with SingleTickerProviderStateMixin {
  int selectedDateIndex = 0;
  ScreeningModel? selectedScreening;
  late TabController _tabController;


  @override
  void initState() {
    super.initState();
    // Initialize TabController
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.white,
                expandedHeight: 450.0,
                pinned: true,
                floating: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: MovieHeader(
                    title: widget.dataMovie.movieTitle,
                    genre: widget.dataMovie.genre,
                    duration:
                        convertMinutesToTimeString(widget.dataMovie.duration),
                    director: widget.dataMovie.director,
                    rating: 4,
                    backgroundImageUrl: widget.dataMovie.cover ?? '',
                    posterImageUrl: widget.dataMovie.cover ?? '',
                    movie: widget.dataMovie,
                  ),
                ),
                bottom: TabBar(
                  controller: _tabController,
                  indicatorColor: Theme.of(context).primaryColor,
                  indicatorWeight: 3,
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(text: 'About Movie'),
                    Tab(text: 'Schedule'),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              // About Movie Tab
              DetailMovieView(
                movie: widget.dataMovie,
              ),
              // Schedule Tab
              DetailScheduleView(
                selectedDateIndex: selectedDateIndex,
                onDateSelected: (index) {
                  setState(() {
                    selectedDateIndex = index;
                    selectedScreening = null;
                  });
                },
                selectedScreening: selectedScreening,
                onScreeningSelected: (screening) {
                  setState(() {
                    selectedScreening = screening;
                  });
                },
                movieID: widget.dataMovie.movieID,
              ),
            ],
          ),
        ),
        bottomNavigationBar: selectedScreening != null
            ? Container(
                width: double.infinity,
                height: 70,
                padding: const EdgeInsets.all(16),
                color: colorPrimary,
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeatSelectionScreen(
                          screening: selectedScreening!,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.local_movies, color: Colors.white),
                  label: const Text(
                    'Buy Ticket',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
