import 'package:atma_cinema/models/screening_model.dart';
import 'package:atma_cinema/models/user_model.dart';
import 'package:atma_cinema/services/auth_service.dart';

class PaymentModel {
  final String paymentID;
  final UserModel user;
  final ScreeningModel screening;
  final String paymentMethod;
  final String paymentStatus;
  final DateTime paymentDate;
  final double totalPayment;

  PaymentModel({
    required this.paymentID,
    required this.user,
    required this.screening,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.paymentDate,
    required this.totalPayment,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      paymentID: json['paymentID'],
      user: UserModel.fromJson(json['user']),
      screening: ScreeningModel.fromJson(json['screening']),
      paymentMethod: json['paymentMethod'],
      paymentStatus: json['paymentStatus'],
      paymentDate: DateTime.parse(json['paymentDate']),
      totalPayment: double.parse(json['totalPayment'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paymentID': paymentID,
      'userID': user.userID,
      'screeningID': screening.screeningID,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'paymentDate': paymentDate.toIso8601String(),
      'totalPayment': totalPayment,
    };
  }
}
