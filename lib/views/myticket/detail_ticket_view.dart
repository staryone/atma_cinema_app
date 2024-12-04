import 'package:atma_cinema/models/ticket_model.dart';
import 'package:atma_cinema/utils/constants.dart';
import 'package:atma_cinema/views/myticket/pdf_invoice.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TicketDetailView extends StatelessWidget {
  final TicketModel ticket;

  const TicketDetailView({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Ticket'),
        backgroundColor: Color(0xFF0A1D37),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(7),
                  topRight: Radius.circular(7),
                ),
                image: DecorationImage(
                  image:
                      NetworkImage(ticket.payment.screening.movie.cover ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      ticket.payment.screening.movie.movieTitle,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              height: 200,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              color: Color(0xFF0A1D37),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Payment ID',
                            style: TextStyle(color: Colors.white)),
                        SizedBox(height: 4.0),
                        Text('Price', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ticket.payment.paymentID,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          'Rp' + ticket.payment.totalPayment.toString(),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 70,
                    child: GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.qr_code,
                        color: Colors.white,
                        size: 60,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          CustomPaint(
            size: const Size(400, 1),
            painter: DashedLinePainter(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              height: 240,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(7),
                    bottomRight: Radius.circular(7)),
                color: Color(0xFFEAD8B1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Ticket ID',
                                style: TextStyle(color: Color(0xFF8B8B89))),
                            SizedBox(height: 4.0),
                            Text(ticket.ticketID,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Studio',
                                style: TextStyle(color: Color(0xFF8B8B89))),
                            SizedBox(height: 4.0),
                            Text(ticket.payment.screening.studio.name,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Seat',
                                style: TextStyle(color: Color(0xFF8B8B89))),
                            SizedBox(height: 4.0),
                            Text(ticket.seatID,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Date',
                                style: TextStyle(color: Color(0xFF8B8B89))),
                            SizedBox(height: 4.0),
                            Text(
                                DateFormat('dd MMM yyyy')
                                    .format(ticket.payment.screening.date),
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Time',
                                style: TextStyle(color: Color(0xFF8B8B89))),
                            SizedBox(height: 4.0),
                            Text(ticket.payment.screening.time,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Total Seats',
                                style: TextStyle(color: Color(0xFF8B8B89))),
                            SizedBox(height: 4.0),
                            Text(
                                'Rp' +
                                    ticket.payment.screening.price.toString() +
                                    ' x 1',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0),
                  Center(
                    child: Text(
                      'Purchased Tickets cannot be exchanged / refund',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Center(
            child: Text(
              'Copyright Atma Cinema',
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Spacer(),
          Container(
            width: double.infinity,
            // padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                createPdf(
                    ticket.payment.user.fullName,
                    ticket.ticketID,
                    ticket.payment.screening.date,
                    ticket.payment.screening.time,
                    ticket.payment.paymentID,
                    ticket.payment.paymentMethod,
                    ticket.payment.paymentDate,
                    ticket.payment.user.userID,
                    context, [
                  CustomRow(ticket.payment.screening.movie.movieTitle, "1",
                      "2000", ticket.payment.totalPayment.toString()),
                ]);
              },
              icon: Icon(Icons.receipt_long),
              label: Text('View Invoice'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorPrimary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const dashWidth = 10.0;
    const dashSpace = 10.0;
    double startX = 0;

    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
