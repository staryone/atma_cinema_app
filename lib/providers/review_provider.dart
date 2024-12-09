import 'package:atma_cinema/clients/review_client.dart';
import 'package:atma_cinema/models/user_review_model.dart';
import 'package:atma_cinema/providers/screening_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reviewClientProvider = Provider(
  (ref) => ReviewClient(),
);

final reviewsFetchAllByMovieProvider =
    FutureProvider<List<UserReviewModel>>((ref) async {
  final reviewClient = ref.read(reviewClientProvider);
  final movieID = ref.watch(movieIDProvider);
  final reviews = await reviewClient.getReviewByMovie(movieID);

  return reviews.map((review) => UserReviewModel.fromJson(review)).toList();
});