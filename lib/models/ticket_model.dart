import 'package:atma_cinema/models/payment_model.dart';

class TicketModel {
  final String ticketID;
  final PaymentModel payment;
  final String seatID;
  final String status;

  TicketModel({
    required this.ticketID,
    required this.payment,
    required this.seatID,
    required this.status,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      ticketID: json['ticketID'],
      payment: PaymentModel.fromJson(json['payment']),
      seatID: json['seatID'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticketID': ticketID,
      'paymentID': payment.paymentID,
      'seatID': seatID,
      'status': status,
    };
  }
}
