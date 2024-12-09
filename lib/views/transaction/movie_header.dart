import 'package:atma_cinema/models/movie_model.dart';
import 'package:atma_cinema/views/transaction/review_view.dart';
import 'package:flutter/material.dart';

class MovieHeader extends StatelessWidget {
  final String title;
  final String genre;
  final String duration;
  final String director;
  final double rating;
  final String backgroundImageUrl;
  final String posterImageUrl;
  final MovieModel movie;

  const MovieHeader({
    Key? key,
    required this.title,
    required this.genre,
    required this.duration,
    required this.director,
    required this.rating,
    required this.backgroundImageUrl,
    required this.posterImageUrl,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Video background
            Image.network(
              backgroundImageUrl,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              child: Center(
                child: Icon(
                  Icons.play_circle_fill,
                  size: 80,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ),
            // Arrow back button
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            // Poster positioned to overlap with video
            Positioned(
              bottom: -170,
              left: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  posterImageUrl,
                  width: 140,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Movie Info
        Padding(
          padding: const EdgeInsets.only(left: 100.0, right: 30.0),
          child: Row(
            children: [
              const SizedBox(width: 100),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Genre: $genre'),
                    Text('Duration: $duration'),
                    Text('Director: $director'),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReviewView(
                            movie: movie,
                            rating: rating,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                // margin: const EdgeInsets.only(bottom: 25.0),
                                child: Text(
                                  rating.toStringAsFixed(1),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                // margin: const EdgeInsets.only(bottom: 25.0),
                                child: Row(
                                  children: List.generate(5, (index) {
                                    if (index < rating.floor()) {
                                      return const Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 20,
                                      );
                                    } else if (index == rating.floor() &&
                                        rating % 1 != 0) {
                                      return const Icon(
                                        Icons.star_half,
                                        color: Colors.orange,
                                        size: 20,
                                      );
                                    } else {
                                      return const Icon(
                                        Icons.star_border,
                                        color: Colors.orange,
                                        size: 20,
                                      );
                                    }
                                  }),
                                ),
                              ),
                            ],
                          ),
                          const Text('See all review')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
