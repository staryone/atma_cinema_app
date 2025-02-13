import 'dart:ui';
import 'package:atma_cinema/models/movie_model.dart';
import 'package:atma_cinema/views/transaction/tab_view.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:atma_cinema/providers/movie_provider.dart';

class CarouselNowShowingMovies extends ConsumerStatefulWidget {
  final double? heightCarousel;
  final bool? enlargeCarousel;
  final bool autoPlayCarousel;
  final double ratioCarousel;
  final bool enableInfiniteScrollCarousel;
  final double viewportFractionCarousel;

  CarouselNowShowingMovies({
    super.key,
    this.heightCarousel = 300,
    this.enlargeCarousel = true,
    this.autoPlayCarousel = false,
    this.ratioCarousel = 3 / 4,
    this.enableInfiniteScrollCarousel = false,
    this.viewportFractionCarousel = 0.55,
  });

  @override
  ConsumerState<CarouselNowShowingMovies> createState() =>
      _CarouselNowShowingMoviesState();
}

class _CarouselNowShowingMoviesState
    extends ConsumerState<CarouselNowShowingMovies> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final moviesAsyncValue = ref.watch(moviesFetchNowShowingProvider);

    return moviesAsyncValue.when(
      loading: () => Skeletonizer(
        enabled: true,
        effect: ShimmerEffect(),
        child: Column(
          children: [
            CarouselSlider.builder(
              itemCount: 3,
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
                count: 3,
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
          return Center(child: Text("No movies available"));
        }

        return Column(
          children: [
            CarouselSlider.builder(
              itemCount: movies.length,
              itemBuilder: (context, index, realIndex) {
                bool isBlur = index == currentIndex;

                final movie = movies[index];
                final imageUrl = movie.cover ?? '';

                return GestureDetector(
                  onTap: () => _onMovieTap(context, movie),
                  child: Stack(
                    children: [
                      if (isBlur && movies.length > 1)
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                          child: Opacity(
                            opacity: 0.6,
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
                          ),
                        ),
                      Container(
                        margin: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          image: DecorationImage(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
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
                enlargeFactor: 0.28,
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
                activeDotColor: const Color(0xfff264968),
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
