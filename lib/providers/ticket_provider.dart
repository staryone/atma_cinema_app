import 'package:atma_cinema/clients/ticket_client.dart';
import 'package:atma_cinema/models/ticket_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ticketClientProvider = Provider(
  (ref) => TicketClient(),
);

final ticketsFetchActiveProvider =
    FutureProvider<List<TicketModel>>((ref) async {
  final ticketClient = ref.read(ticketClientProvider);
  final tickets = await ticketClient.fetchActiveOrders();

  return tickets.map((ticket) => TicketModel.fromJson(ticket)).toList();
});
