// lib/components/carousel_with_indicator.dart
import 'package:atma_cinema/models/movie_model.dart';
import 'package:atma_cinema/providers/movie_provider.dart';
import 'package:atma_cinema/views/transaction/tab_view.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselUpcomingMovies extends ConsumerStatefulWidget {
  final double? heightCarousel;
  final bool? enlargeCarousel;
  final bool autoPlayCarousel;
  final double ratioCarousel;
  final bool enableInfiniteScrollCarousel;
  final double viewportFractionCarousel;

  CarouselUpcomingMovies({
    super.key,
    this.heightCarousel = 240,
    this.enlargeCarousel = false,
    this.autoPlayCarousel = false,
    this.ratioCarousel = 3 / 4,
    this.enableInfiniteScrollCarousel = true,
    this.viewportFractionCarousel = 0.47,
  });

  @override
  ConsumerState<CarouselUpcomingMovies> createState() =>
      _CarouselUpcomingMoviesState();
}

class _CarouselUpcomingMoviesState
    extends ConsumerState<CarouselUpcomingMovies> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final moviesAsyncValue = ref.watch(moviesFetchUpcomingProvider);

    return moviesAsyncValue.when(
      loading: () => Skeletonizer(
        child: Column(
          children: [
            CarouselSlider.builder(
              itemCount: 5,
              itemBuilder: (context, index, realIndex) {
                return Container(
                  margin: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                );
              },
              options: CarouselOptions(
                height: widget.heightCarousel,
                enlargeCenterPage: widget.enlargeCarousel,
                aspectRatio: widget.ratioCarousel,
                viewportFraction: widget.viewportFractionCarousel,
              ),
            ),
            const SizedBox(height: 20),
            Skeletonizer(
              child: AnimatedSmoothIndicator(
                activeIndex: 0,
                count: 5,
                effect: ExpandingDotsEffect(
                  expansionFactor: 2,
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: const Color(0xfff264968),
                  dotColor: Colors.grey.shade300,
                ),
              ),
            ),
          ],
        ),
      ),
      error: (err, stack) => Center(child: Text('Error: $err')),
      data: (movies) {
        if (movies.isEmpty) {
          return Center(child: Text("No upcoming movies available"));
        }
        return Column(
          children: [
            CarouselSlider.builder(
              itemCount: movies.length,
              itemBuilder: (context, index, realIndex) {
                final movie = movies[index];
                final imageUrl = movie.cover ?? '';

                return GestureDetector(
                  onTap: () => _onMovieTap(context, movie),
                  child: Container(
                    margin: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: widget.heightCarousel,
                enlargeCenterPage: widget.enlargeCarousel,
                autoPlay: widget.autoPlayCarousel,
                aspectRatio: widget.ratioCarousel,
                enableInfiniteScroll: widget.enableInfiniteScrollCarousel,
                viewportFraction: widget.viewportFractionCarousel,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            AnimatedSmoothIndicator(
              activeIndex: currentIndex,
              count: movies.length,
              effect: ExpandingDotsEffect(
                expansionFactor: 2,
                dotHeight: 8,
                dotWidth: 8,
                activeDotColor: Color(0xfff264968),
                dotColor: Colors.grey.shade400,
              ),
            ),
          ],
        );
      },
    );
  }

  void _onMovieTap(BuildContext context, MovieModel movie) {
    print(movie.movieTitle as String);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieTabPage(
          dataMovie: movie,
        ),
      ),
    );
  }
}
