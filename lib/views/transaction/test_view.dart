import 'package:flutter/material.dart';

class MovieTestPage extends StatelessWidget {
  int selectedIndex = 0;
  final List<Map<String, String>> dates = [
    {'day': '12', 'label': 'Today'},
    {'day': '13', 'label': 'Sun'},
    {'day': '14', 'label': 'Mon'},
    {'day': '15', 'label': 'Tue'},
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            // Header
            Stack(
              children: [
                Image.network(
                  'https://m.media-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_SX300.jpg',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Row(
                    children: [
                      Icon(Icons.play_circle_fill,
                          size: 50, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        'Dilan 1990',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Movie Info
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  'https://m.media-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_SX300.jpg', // Replace with your image path
                                  width: 100,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Dilan 1990',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text('Genre: Drama, Romance'),
                                    Text('Duration: 1 hour 20 minute'),
                                    Text('Director: Fajar Bustomi'),
                                    SizedBox(height: 8),
                                    Row(
                                      children: List.generate(5, (index) {
                                        return Icon(
                                          index < 3.5
                                              ? Icons.star
                                              : Icons.star_half,
                                          color: Colors.orange,
                                          size: 20,
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          // Tab Section
                          TabBar(
                            indicatorColor: Colors.blue,
                            labelColor: Colors.blue,
                            unselectedLabelColor: Colors.grey,
                            tabs: [
                              Tab(text: 'About Movie'),
                              Tab(text: 'Schedule'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverFillRemaining(
                    child: TabBarView(
                      children: [
                        // About Movie
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Dilan 1990 is a romantic drama movie that tells the story of love and adolescence. The plot centers around... (Add movie details here)',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        // Schedule
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: List.generate(dates.length, (index) {
                                  final isSelected = index == selectedIndex;
                                  return GestureDetector(
                                    onTap: () {
                                      // setState(() {
                                      //   selectedIndex = index;
                                      // });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Colors.blue
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            dates[index]['day']!,
                                            style: TextStyle(
                                              color: isSelected
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            dates[index]['label']!,
                                            style: TextStyle(
                                              color: isSelected
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                              SizedBox(height: 8),
                              ScheduleSection(
                                title: 'Reguler 2D',
                                price: 'Rp 45.000',
                                times: [
                                  '13.00',
                                  '15.00',
                                  '17.00',
                                  '19.00',
                                  '21.00'
                                ],
                              ),
                              SizedBox(height: 16),
                              ScheduleSection(
                                title: 'Reguler 3D',
                                price: 'Rp 40.000',
                                times: [
                                  '13.00',
                                  '15.00',
                                  '17.00',
                                  '19.00',
                                  '21.00'
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Buy Ticket Button
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.blue,
              child: TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.local_movies, color: Colors.white),
                label: Text(
                  'Buy Ticket',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScheduleSection extends StatelessWidget {
  final String title;
  final String price;
  final List<String> times;

  const ScheduleSection({
    Key? key,
    required this.title,
    required this.price,
    required this.times,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50], // Latar belakang
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!), // Warna border
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: $price',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900], // Warna teks judul
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: times.map((time) {
              return OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.blue), // Warna border tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                child: Text(
                  time,
                  style: TextStyle(
                    color: Colors.blue[900], // Warna teks tombol
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
