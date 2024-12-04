import 'package:atma_cinema/models/payment_model.dart';
import 'package:atma_cinema/models/review_model.dart';

class HistoryModel {
  final String historyID;
  final String userID;
  final PaymentModel payment;
  final ReviewModel? review;

  HistoryModel(
      {required this.historyID,
      required this.userID,
      required this.payment,
      this.review});

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return HistoryModel(
      historyID: json['historyID'],
      userID: json['userID'],
      payment: json['payment'] != null
          ? PaymentModel.fromJson(json['payment'] as Map<String, dynamic>)
          : throw Exception('Payment data is missing in history JSON'),
      review: json['review'] != null && json['review'] is Map<String, dynamic>
          ? ReviewModel.fromJson(Map<String, dynamic>.from(json['review']))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'historyID': historyID,
      'userID': userID,
      'paymentID': payment.paymentID,
      'reviewID': review?.reviewID,
    };
  }
}
