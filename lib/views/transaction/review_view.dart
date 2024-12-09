import 'package:atma_cinema/clients/review_client.dart';
import 'package:atma_cinema/models/user_review_model.dart';
import 'package:atma_cinema/providers/review_provider.dart';
import 'package:atma_cinema/providers/screening_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:atma_cinema/models/movie_model.dart';
import 'package:atma_cinema/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Ubah menjadi ConsumerWidget
class ReviewView extends ConsumerWidget {
  final MovieModel movie;
  final double rating;

  ReviewView({required this.movie, required this.rating});

  String formatDateTime(DateTime date) {
    DateTime dateTime = DateTime(
      date.year,
      date.month,
      date.day,
    );
    return DateFormat("EEEE, dd MMM yyyy").format(dateTime);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewsAsyncValue = ref.watch(reviewsFetchAllByMovieProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: colorPrimary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Review',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Header Film
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        movie.cover ?? '',
                        width: 100,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.movieTitle,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          movie.ageRating,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 32),
                            SizedBox(width: 8),
                            Text(
                              '4.0',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                                color: Colors.amber,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Text(
                            '37 ratings - 11 reviews',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Divider(),

              reviewsAsyncValue.when(
                loading: () => Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Center(
                    child: Text(
                      'Reviews not found',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                data: (reviews) {
                  if (reviews.isEmpty) {
                    return Center(
                      child: Text(
                        'No reviews found for this movie.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: reviews.length,
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (context, index) {
                      final review = reviews[index];
                      return _buildReviewItem(
                        review.fullName,
                        review.comment ?? 'No comment provided.',
                        review.rating.toDouble(),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk menampilkan review item
  Widget _buildReviewItem(String fullName, String review, double rating) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fullName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 4),
          Row(
            children: List.generate(5, (index) {
              if (index < rating.floor()) {
                return Icon(Icons.star, color: Colors.amber, size: 16);
              } else if (index < rating) {
                return Icon(Icons.star_half, color: Colors.amber, size: 16);
              } else {
                return Icon(Icons.star_border, color: Colors.amber, size: 16);
              }
            }),
          ),
          SizedBox(height: 8),
          Text(
            "Description:",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          SizedBox(height: 4),
          Text(
            review,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
