// import 'package:flutter/material.dart';

// class HistoryOrderView extends StatefulWidget {
//   const HistoryOrderView({super.key});

//   @override
//   State<HistoryOrderView> createState() => _HistoryOrderViewState();
// }

// class _HistoryOrderViewState extends State<HistoryOrderView> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         Column(
//           children: [
//             Icon(
//               Icons.movie,
//               size: 80,
//               color: Color(0xFF0A1D37),
//             ),
//             SizedBox(height: 20),
//             Text(
//               "Oops, History not Found!",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Get exciting movie tickets, on the Atma Cinema',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey,
//               ),
//             ),
//             SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 fixedSize: Size(128, 28),
//                 backgroundColor: Color(0xFF0A1D37),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//               child: Text(
//                 'See a movie',
//                 style: TextStyle(fontSize: 14, color: Colors.white),
//               ),
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

class HistoryOrderView extends StatefulWidget {
  const HistoryOrderView({super.key});

  @override
  State<HistoryOrderView> createState() => _HistoryOrderViewState();
}

class _HistoryOrderViewState extends State<HistoryOrderView> {
  Map<String, double> movieRatings = {
    'Spiderman': 0,
    'Marmut Merah Jambu': 0,
  };

  @override
  void initState() {
    super.initState();
    // Remove any focused widget when this screen appears
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }

  void showRatingSheet(String movieTitle) {
    double tempRating = movieRatings[movieTitle]!;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                height: 400,
                padding: EdgeInsets.all(20),
                color: Colors.white, // Background color set to white
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      movieTitle,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
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
                    SizedBox(height: 20),
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
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          movieRatings[movieTitle] = tempRating;
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0A1D37),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors
                              .white, // Save button text color set to white
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 4), // Reduced vertical padding
        children: [
          buildMovieCard(
            'Spiderman',
            'Action',
            '1 hour 32 minutes',
            'Satria Mahatier',
          ),
          Divider(height: 1, color: Colors.grey[300]),
          buildMovieCard(
            'Marmut Merah Jambu',
            'Drama, Comedy',
            '1 hour 20 minutes',
            'Raditya Dika',
          ),
        ],
      ),
    );
  }

  Widget buildMovieCard(
      String title, String genre, String duration, String director) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 100,
                width: 70,
                color: Colors.grey,
                child: Center(
                  child: Text(
                    'Poster',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          movieRatings[title]?.toStringAsFixed(1) ?? '0.0',
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text('Genre: $genre'),
                    Text('Duration: $duration'),
                    Text('Director: $director'),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          movieRatings[title]! > 0
              ? Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
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
                                index < movieRatings[title]!
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 20,
                              );
                            }),
                          ),
                          SizedBox(width: 8),
                          Text(
                            movieRatings[title]!.toStringAsFixed(1),
                            style: TextStyle(
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
                  onPressed: () => showRatingSheet(title),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0A1D37),
                    minimumSize: Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Rate',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
        ],
      ),
    );
  }
}
