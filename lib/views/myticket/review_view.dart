import 'package:flutter/material.dart';

class ReviewView extends StatelessWidget {
  final String movieTitle;

  // Constructor menerima movieTitle dari halaman sebelumnya
  ReviewView({required this.movieTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
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
                      child: Image.asset(
                        '', // Tambahkan gambar poster jika ada
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
                          movieTitle,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Monday, 12 August 2023',
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

              // Review List
              _buildReviewItem('@user5678', 'BAGUSS film fav saya!!!', 4.5),
              _buildReviewItem('@user5678', 'BAGUSS film fav saya!!!', 4.5),
              _buildReviewItem('@user5678', 'BAGUSS film fav saya!!!', 4.5),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk menampilkan review item
  Widget _buildReviewItem(String username, String review, double rating) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            username,
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
          Divider(),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ReviewView(movieTitle: 'Dilan 1990'),
  ));
}
