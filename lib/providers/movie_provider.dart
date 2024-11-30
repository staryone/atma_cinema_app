import 'package:atma_cinema/models/movie_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:atma_cinema/clients/movie_client.dart';

final movieClientProvider = Provider(
  (ref) => MovieClient(),
);

final moviesFetchAllProvider = FutureProvider<List<String>>((ref) async {
  final movieClient = ref.read(movieClientProvider);
  final movies = await movieClient.fetchAllMovies();

  return movies.map((movie) => movie['cover'] as String).toList();
});

final moviesFetchUpcomingProvider = FutureProvider<List<String>>((ref) async {
  final movieClient = ref.read(movieClientProvider);
  final movies = await movieClient.fetchUpcomingMovies();

  return movies.map((movie) => movie['cover'] as String).toList();
});

final moviesFetchNowShowingProvider =
    FutureProvider<List<MovieModel>>((ref) async {
  final movieClient = ref.read(movieClientProvider);
  final movies = await movieClient.fetchNowShowingMovies();
  return movies.map((movie) => MovieModel.fromJson(movie)).toList();
});
