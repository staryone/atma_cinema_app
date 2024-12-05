import 'package:atma_cinema/views/transaction/payment/confirm_payment_view.dart';
import 'package:flutter/material.dart';
import 'package:atma_cinema/views/transaction/detail_schedule_view.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(const MovieDetailApp());

class MovieDetailApp extends StatelessWidget {
  const MovieDetailApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MovieDetailScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({Key? key}) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late VideoPlayerController _videoController;
  String selectedTab = "About Movie"; // Default tab

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/testing_video.mp4')
      ..initialize().then((_) {
        setState(() {
          print("Video initialized successfully.");
        });
      }).catchError((error) {
        print("Error initializing video: $error");
      });
  }

  @override
  void dispose() {
    _videoController.dispose(); // Dispose of the controller to free resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Column(
            children: [
              // Top Video Section
              Stack(
                children: [
                  _videoController.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _videoController.value.aspectRatio,
                          child: VideoPlayer(_videoController),
                        )
                      : Container(
                          height: 300,
                          width: double.infinity,
                          color: Colors.black,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                  Positioned(
                    top: 120,
                    left: MediaQuery.of(context).size.width / 2 - 30,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_videoController.value.isPlaying) {
                            _videoController.pause();
                            print("Video paused.");
                          } else {
                            _videoController.play();
                            print("Video playing.");
                          }
                        });
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Icon(
                          _videoController.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Movie Details Section
              Expanded(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Movie Poster
                          Image.network(
                            'https://m.media-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_SX300.jpg',
                            width: 100,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 16),
                          // Movie Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Dilan 1990',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Genre: Drama, Romance',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  'Duration: 1 hour 20 minute',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  'Director: Fajar Bustomi',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Rating Section
                      Row(
                        children: const [
                          Text(
                            '3.5',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.star, color: Colors.yellow, size: 24),
                          Icon(Icons.star, color: Colors.yellow, size: 24),
                          Icon(Icons.star, color: Colors.yellow, size: 24),
                          Icon(Icons.star_half, color: Colors.yellow, size: 24),
                          Icon(Icons.star_border, color: Colors.grey, size: 24),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Tab Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedTab = "About Movie";
                              });
                            },
                            child: Text(
                              'About Movie',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: selectedTab == "About Movie"
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedTab = "Schedule";
                              });
                            },
                            child: Text(
                              'Schedule',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: selectedTab == "Schedule"
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      // Conditional content based on selected tab
                      Expanded(
                        child: selectedTab == "About Movie"
                            ? const AboutMovieContent()
                            : const AboutMovieContent(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Buy Ticket Button
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Navigating to the ConfirmPaymentScreen when the button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ConfirmPaymentPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Buy Ticket',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AboutMovieContent extends StatelessWidget {
  const AboutMovieContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'About Movie',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Dilan 1990 is a romantic drama film about a young love story '
          'between Dilan and Milea in the 1990s. The movie explores their '
          'unique bond, challenges, and heartwarming moments.',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
