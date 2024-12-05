import 'package:atma_cinema/models/movie_model.dart';
import 'package:flutter/material.dart';

class DetailMovieView extends StatefulWidget {
  final MovieModel movie;

  const DetailMovieView({super.key, required this.movie});

  @override
  State<DetailMovieView> createState() => _DetailMovieViewState();
}

class _DetailMovieViewState extends State<DetailMovieView> {
  // List of cast images
  final List<String> castImages = [
    "https://image.tmdb.org/t/p/w500/ycZpLjHxsNPvsB6ndu2D9qsx94X.jpg",
    "https://image.tmdb.org/t/p/w500/ycZpLjHxsNPvsB6ndu2D9qsx94X.jpg",
    "https://image.tmdb.org/t/p/w500/ycZpLjHxsNPvsB6ndu2D9qsx94X.jpg",
    "https://image.tmdb.org/t/p/w500/ycZpLjHxsNPvsB6ndu2D9qsx94X.jpg",
    "https://image.tmdb.org/t/p/w500/ycZpLjHxsNPvsB6ndu2D9qsx94X.jpg",
    "https://image.tmdb.org/t/p/w500/ycZpLjHxsNPvsB6ndu2D9qsx94X.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.movie.movieTitle,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.movie.synopsis ?? '',
              style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
            ),
            const SizedBox(height: 16),
            const Text(
              "Producer",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            Text(
              widget.movie.director,
              style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
            ),
            const SizedBox(height: 8),
            const Text(
              "Director",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            Text(
              widget.movie.director,
              style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
            ),
            const SizedBox(height: 8),
            const Text(
              "Writers",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            Text(
              widget.movie.writers ?? '',
              style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
            ),
            const SizedBox(height: 16),
            const Text(
              "Cast",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: castImages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      width: 90,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(castImages[index]),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
