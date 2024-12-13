import 'package:atma_cinema/clients/history_client.dart';
import 'package:atma_cinema/clients/review_client.dart';
import 'package:atma_cinema/components/custom_snackbar_component.dart';
import 'package:atma_cinema/utils/time_utils.dart';
import 'package:atma_cinema/views/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:atma_cinema/providers/history_provider.dart';

class HistoryOrderView extends ConsumerStatefulWidget {
  const HistoryOrderView({super.key});

  @override
  ConsumerState<HistoryOrderView> createState() => _HistoryOrderViewState();
}

class _HistoryOrderViewState extends ConsumerState<HistoryOrderView> {
  @override
  Widget build(BuildContext context) {
    final historyAsyncValue = ref.watch(historysFetchActiveProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: historyAsyncValue.when(
        data: (historyList) {
          if (historyList.isEmpty) {
            return ListView(
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.movie,
                      size: 80,
                      color: Color(0xFF0A1D37),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Oops, History not Found!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Get exciting movie tickets, on the Atma Cinema',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchView(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(128, 28),
                        backgroundColor: Color(0xFF0A1D37),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'See a movie',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 4),
            itemCount: historyList.length,
            itemBuilder: (context, index) {
              final history = historyList[index];
              final movieTitle = history.payment.screening.movie.movieTitle;
              final review = history.review;
              final String cover = history.payment.screening.movie.cover ?? '';

              return Column(
                children: [
                  buildMovieCard(
                    title: movieTitle,
                    genre: history.payment.screening.movie.genre,
                    duration: convertMinutesToTimeString(
                        history.payment.screening.movie.duration),
                    director: history.payment.screening.movie.director,
                    cover: cover,
                    review: review,
                    historyID: history.historyID,
                    movieID: history.payment.screening.movie.movieID,
                  ),
                  Divider(height: 1, color: Colors.grey[300]),
                ],
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget buildMovieCard({
    required String title,
    required String genre,
    required String duration,
    required String director,
    required String cover,
    required dynamic review,
    required String movieID,
    required String historyID,
  }) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  height: 100,
                  width: 70,
                  color: Colors.grey,
                  child: Image.network(
                    cover,
                  )),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Genre: $genre'),
                    Text('Duration: $duration'),
                    Text('Director: $director'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          review != null
              ? Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'My Rating Score:',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Row(
                        children: [
                          Row(
                            children: List.generate(5, (index) {
                              return Icon(
                                index < review.rating
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 20,
                              );
                            }),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            review.rating.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : ElevatedButton(
                  onPressed: () => showRatingSheet(title, historyID, movieID),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A1D37),
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Rate',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
        ],
      ),
    );
  }

  Future<void> _refreshData() async {
    ref.invalidate(historysFetchActiveProvider);
  }

  void showRatingSheet(String movieTitle, String historyID, String movieID) {
    double tempRating = 0;
    String? comment;
    final ReviewClient reviewClient = ReviewClient();
    final HistoryClient historyClient = HistoryClient();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                height: 400,
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      movieTitle,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            index < tempRating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                          ),
                          iconSize: 36,
                          onPressed: () {
                            setModalState(() {
                              tempRating = index + 1.0;
                            });
                          },
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Your Comment',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Write here...',
                      ),
                      maxLines: 5,
                      onChanged: (value) => comment = value,
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () async {
                        if (tempRating == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please give a rating.')),
                          );
                          return;
                        }

                        try {
                          final reviewData = {
                            "comment": comment ?? "",
                            "rating": tempRating.toInt(),
                          };

                          final reviewResponse =
                              await reviewClient.createReview(
                            reviewData,
                            movieID,
                          );

                          final reviewID = reviewResponse['data']['reviewID'];

                          final response =
                              await historyClient.addReviewToHistory(
                            {"reviewID": reviewID},
                            historyID,
                          );

                          _refreshData();
                          CustomSnackbarComponent.showCustomSuccess(
                              context, "Review saved successfully!");

                          Navigator.pop(context);
                        } catch (e) {
                          CustomSnackbarComponent.showCustomError(
                              context, "Review saved failed!");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0A1D37),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
