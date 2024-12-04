import 'package:atma_cinema/models/ticket_model.dart';
import 'package:atma_cinema/providers/ticket_provider.dart';
import 'package:atma_cinema/utils/constants.dart';
import 'package:atma_cinema/views/myticket/detail_ticket_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ActiveOrderView extends ConsumerStatefulWidget {
  const ActiveOrderView({super.key});

  @override
  ConsumerState<ActiveOrderView> createState() => _ActiveOrderViewState();
}

class _ActiveOrderViewState extends ConsumerState<ActiveOrderView> {
  @override
  Widget build(BuildContext context) {
    final ticketsAsyncValue = ref.watch(ticketsFetchActiveProvider);
    return ticketsAsyncValue.when(
      data: (tickets) {
        if (tickets.length <= 0 || tickets.isEmpty) {
          return Column(
            children: [
              Icon(
                Icons.movie,
                size: 80,
                color: Color(0xFF0A1D37),
              ),
              SizedBox(height: 20),
              Text(
                "Let's watch a movie!",
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
                onPressed: () {},
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
          );
        }
        return ListView.builder(
          itemCount: tickets.length,
          itemBuilder: (context, index) {
            final ticket = tickets[index];
            final date = ticket.payment.screening.date;
            final formattedDate = DateFormat('yyyy-MM-dd').format(date);
            final time = ticket.payment.screening.time;
            final dateTimeString = "$formattedDate $time";
            final dateTime = DateTime.parse(dateTimeString);
            final formattedDateFinal =
                DateFormat('EEEE, dd MMM yyyy, HH:mm').format(dateTime);
            return OrderCard(
              imageUrl: ticket.payment.screening.movie.cover ?? '',
              title: ticket.payment.screening.movie.movieTitle,
              ticketInfo: 'Ticket (1)',
              studio: ticket.payment.screening.studio.name,
              date: formattedDateFinal,
              status: ticket.status,
              ticket: ticket,
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Text(
          'Failed to load tickets: $error',
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
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
  final TicketModel ticket;

  const OrderCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.ticketInfo,
    required this.studio,
    required this.date,
    required this.status,
    required this.ticket,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TicketDetailView(ticket: ticket)),
        );
      },
      child: Column(
        children: [
          Container(
            color: Color.fromARGB(255, 252, 252, 252),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, bottom: 16.0, top: 16),
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
          Divider(
            height: 2,
            thickness: 1,
            color: Colors.grey.shade300,
          )
        ],
      ),
    );
  }
}
