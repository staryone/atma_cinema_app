class TicketModel {
  final String ticketID;
  final String paymentID;
  final String userID;
  final String screeningID;
  final String seatID;
  final String status;

  TicketModel({
    required this.ticketID,
    required this.paymentID,
    required this.userID,
    required this.screeningID,
    required this.seatID,
    required this.status,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      ticketID: json['ticketID'],
      paymentID: json['paymentID'],
      userID: json['userID'],
      screeningID: json['screeningID'],
      seatID: json['seatID'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticketID': ticketID,
      'paymentID': paymentID,
      'userID': userID,
      'screeningID': screeningID,
      'seatID': seatID,
      'status': status,
    };
  }
}
