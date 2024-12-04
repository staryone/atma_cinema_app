import 'package:atma_cinema/models/movie_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:atma_cinema/clients/movie_client.dart';

final movieClientProvider = Provider(
  (ref) => MovieClient(),
);

final querySearchProvider = StateProvider<String>((ref) => '');

final moviesFetchAllProvider = FutureProvider<List<MovieModel>>((ref) async {
  final movieClient = ref.read(movieClientProvider);
  final movies = await movieClient.fetchAllMovies();

  return movies.map((movie) => MovieModel.fromJson(movie)).toList();
});

final moviesFetchUpcomingProvider =
    FutureProvider<List<MovieModel>>((ref) async {
  final movieClient = ref.read(movieClientProvider);
  final movies = await movieClient.fetchUpcomingMovies();

  return movies.map((movie) => MovieModel.fromJson(movie)).toList();
});

final moviesFetchNowShowingProvider =
    FutureProvider<List<MovieModel>>((ref) async {
  final movieClient = ref.read(movieClientProvider);
  final movies = await movieClient.fetchNowShowingMovies();
  return movies.map((movie) => MovieModel.fromJson(movie)).toList();
});

final moviesSearchProvider = FutureProvider<List<MovieModel>>((ref) async {
  final movieClient = ref.read(movieClientProvider);
  final querySearch = ref.watch(querySearchProvider);
  final movies = await movieClient.searchMovies(querySearch);
  return movies.map((movie) => MovieModel.fromJson(movie)).toList();
});
