import 'package:atma_cinema/models/movie_model.dart';
import 'package:atma_cinema/models/promo_model.dart';
import 'package:atma_cinema/providers/movie_provider.dart';
import 'package:atma_cinema/views/detail_promo_view.dart';
import 'package:atma_cinema/views/transaction/tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ListItemSearch extends ConsumerStatefulWidget {
  const ListItemSearch({super.key});

  @override
  ConsumerState<ListItemSearch> createState() => _ListItemSearchState();
}

class _ListItemSearchState extends ConsumerState<ListItemSearch> {
  @override
  Widget build(BuildContext context) {
    final querySearch = ref.watch(querySearchProvider);
    return Expanded(
      child: ref.watch(moviesSearchProvider).when(
            data: (movies) {
              if (movies.isEmpty || movies == []) {
                return Center(
                  child: Text('Oops, we couldn\'t locate \"$querySearch\"'),
                );
              }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return Container(
                    margin: EdgeInsets.only(right: 16),
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.black.withOpacity(0.1),
                      //     blurRadius: 5,
                      //   ),
                      // ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              movie.cover ?? '',
                              height: 240,
                              width: 160,
                              fit: BoxFit.cover,
                            ),
                          ),
                          onTap: () => _onMovieTap(context, movie),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  );
                },
              );
            },
            loading: () => _buildSkeletonPlaceholder(),
            error: (error, stack) => Center(child: Text('Error: $error')),
          ),
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

Widget _buildSkeletonPlaceholder() {
  return Skeletonizer(
    ignoreContainers: true,
    effect: ShimmerEffect(),
    enabled: true,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (context, index) {
        return SizedBox(
          height: 240,
          width: 160,
        );
      },
    ),
  );
}
