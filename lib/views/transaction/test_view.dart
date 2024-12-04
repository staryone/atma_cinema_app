import 'package:atma_cinema/utils/constants.dart';
import 'package:atma_cinema/views/transaction/seat_view.dart';
import 'package:flutter/material.dart';

class MovieTestPage extends StatefulWidget {
  @override
  _MovieTestPageState createState() => _MovieTestPageState();
}

class _MovieTestPageState extends State<MovieTestPage> {
  int selectedIndex = 0;
  int? selected2DTimeIndex;
  int? selected3DTimeIndex;

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Stack(
                clipBehavior: Clip.none,
                children: [
                  // Video background
                  Image.network(
                    'https://m.media-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_SX300.jpg',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned.fill(
                    child: Center(
                      child: Icon(
                        Icons.play_circle_fill,
                        size: 80,
                        color: Colors.white.withOpacity(0.7), // Kurangi opacity
                      ),
                    ),
                  ),
                  // Arrow back button
                  Positioned(
                    top: 10, // Sesuaikan posisi vertikal tombol
                    left: 10, // Sesuaikan posisi horizontal tombol
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  // Poster positioned to overlap with video
                  Positioned(
                    bottom: -170,
                    left: 30,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://m.media-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_SX300.jpg',
                        width: 140,
                        height: 190,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // Movie Info
              Padding(
                padding: const EdgeInsets.only(left: 100.0, right: 30.0),
                child: Row(
                  children: [
                    SizedBox(width: 100),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dilan 1990',
                            style: TextStyle(
                              fontSize: 24, // Besar font lebih besar
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text('Genre: Drama, Romance'),
                          Text('Duration: 1 hour 20 minute'),
                          Text('Director: Fajar Bustomi'),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    bottom: 25.0), // Menambahkan margin bottom
                                child: Text(
                                  '3.5',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: colorPrimary,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Container(
                                margin: const EdgeInsets.only(
                                    bottom: 25.0), // Menambahkan margin bottom
                                child: Row(
                                  children: List.generate(5, (index) {
                                    if (index < 3) {
                                      return Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 20,
                                      );
                                    } else if (index == 3) {
                                      return Icon(
                                        Icons.star_half,
                                        color: Colors.orange,
                                        size: 20,
                                      );
                                    } else {
                                      return Icon(
                                        Icons.star_border,
                                        color: Colors.orange,
                                        size: 20,
                                      );
                                    }
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20), // Jarak antara Movie Info dan TabBar

              // Tab Section
              TabBar(
                indicatorColor: colorPrimary,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3,
                labelColor: colorPrimary,
                unselectedLabelColor: Colors.grey,
                labelStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold), // Tambahkan style
                tabs: [
                  Tab(text: 'About Movie'),
                  Tab(text: 'Schedule'),
                ],
              ),
              Container(
                height: 500,
                child: TabBarView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Dilan 1990 is a romantic drama movie that tells the story of love and adolescence. The plot centers around... (Add movie details here)',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(dates.length, (index) {
                              final isSelected = index == selectedIndex;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? colorPrimary
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
                            selectedIndex: selected2DTimeIndex,
                            onTimeSelected: (index) {
                              setState(() {
                                selected2DTimeIndex = index;
                              });
                            },
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
                            selectedIndex: selected3DTimeIndex,
                            onTimeSelected: (index) {
                              setState(() {
                                selected3DTimeIndex = index;
                              });
                            },
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
        bottomNavigationBar: Container(
          width: double.infinity,
          height: 70,
          padding: const EdgeInsets.all(16),
          color: colorPrimary,
          child: TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SeatSelectionScreen(),
                ),
              );
            },
            icon: Icon(Icons.local_movies, color: Colors.white),
            label: Text(
              'Buy Ticket',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}

class ScheduleSection extends StatelessWidget {
  final String title;
  final String price;
  final List<String> times;
  final int? selectedIndex;
  final ValueChanged<int> onTimeSelected;

  const ScheduleSection({
    Key? key,
    required this.title,
    required this.price,
    required this.times,
    this.selectedIndex,
    required this.onTimeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 247, 247, 247),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$title:: $price',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: colorPrimary,
              ),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2.5,
              ),
              itemCount: times.length,
              itemBuilder: (context, index) {
                final time = times[index];
                final isSelected = index == selectedIndex;
                return OutlinedButton(
                  onPressed: () => onTimeSelected(index),
                  style: OutlinedButton.styleFrom(
                    backgroundColor:
                        isSelected ? colorPrimary : Colors.transparent,
                    side: BorderSide(
                      color: const Color.fromARGB(255, 150, 150, 150),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  child: Text(
                    time,
                    style: TextStyle(
                      color: isSelected ? Colors.white : colorPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
