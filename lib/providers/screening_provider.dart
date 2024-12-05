import 'package:atma_cinema/clients/screening_client.dart';
import 'package:atma_cinema/models/screening_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final screeningClientProvider = Provider(
  (ref) => ScreeningClient(),
);

final movieIDProvider = StateProvider<String>((ref) => '');

final screeningsFetchByMovieProvider =
    FutureProvider<List<ScreeningModel>>((ref) async {
  final screeningClient = ref.read(screeningClientProvider);
  final movieID = ref.watch(movieIDProvider);
  final screenings = await screeningClient.fetchScreeningByMovie(movieID);

  return screenings
      .map((screening) => ScreeningModel.fromJson(screening))
      .toList();
});
