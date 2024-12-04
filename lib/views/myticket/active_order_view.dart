import 'package:atma_cinema/utils/constants.dart';
import 'package:atma_cinema/views/myticket/detail_ticket_view.dart';
import 'package:flutter/material.dart';

class ActiveOrderView extends StatefulWidget {
  const ActiveOrderView({super.key});

  @override
  State<ActiveOrderView> createState() => _ActiveOrderViewState();
}

class _ActiveOrderViewState extends State<ActiveOrderView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(0.0),
      children: [
        OrderCard(
          imageUrl:
              "https://i.pinimg.com/564x/a4/9d/c8/a49dc85d98d25389f9d939bbd8663e43.jpg",
          title: 'Dilan 1990',
          ticketInfo: 'Ticket (1)',
          studio: 'Studio 2',
          date: 'Saturday, 12 Oct 2021, 13:00',
          status: 'Success',
        ),
        const SizedBox(height: 16),
        OrderCard(
          imageUrl:
              "https://i.pinimg.com/736x/2a/02/14/2a021436434b66ad17e42a658ca3445b.jpg",
          title: 'Excavator',
          ticketInfo: 'Ticket (2)',
          studio: 'Studio 3',
          date: 'Sunday, 13 Oct 2021, 21:00',
          status: 'Success',
        ),
        // Column(
        //   children: [
        //     Icon(
        //       Icons.movie,
        //       size: 80,
        //       color: Color(0xFF0A1D37),
        //     ),
        //     SizedBox(height: 20),
        //     Text(
        //       "Let's watch a movie!",
        //       style: TextStyle(
        //         fontSize: 18,
        //         fontWeight: FontWeight.bold,
        //         color: Colors.black,
        //       ),
        //     ),
        //     SizedBox(height: 10),
        //     Text(
        //       'Get exciting movie tickets, on the Atma Cinema',
        //       textAlign: TextAlign.center,
        //       style: TextStyle(
        //         fontSize: 14,
        //         color: Colors.grey,
        //       ),
        //     ),
        //     SizedBox(height: 30),
        //     ElevatedButton(
        //       onPressed: () {},
        //       style: ElevatedButton.styleFrom(
        //         fixedSize: Size(128, 28),
        //         backgroundColor: Color(0xFF0A1D37),
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(20),
        //         ),
        //       ),
        //       child: Text(
        //         'See a movie',
        //         style: TextStyle(fontSize: 14, color: Colors.white),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}

class OrderCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String ticketInfo;
  final String studio;
  final String date;
  final String status;

  const OrderCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.ticketInfo,
    required this.studio,
    required this.date,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TicketDetailPage()),
        );
      },
      child: Container(
        color: Color.fromARGB(255, 252, 252, 252),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  height: 117,
                  width: 90,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ticketInfo,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      studio,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                status,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
