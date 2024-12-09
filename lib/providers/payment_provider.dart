import 'package:atma_cinema/clients/payment_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final paymentClientProvider = Provider<PaymentClient>((ref) {
  return PaymentClient();
});

final getPaymentByIdProvider = FutureProvider.family<dynamic, String>((ref, id) async {
  final paymentClient = ref.read(paymentClientProvider);
  return await paymentClient.getPaymentById(id);
});