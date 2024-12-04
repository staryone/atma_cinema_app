import 'package:atma_cinema/clients/history_client.dart';
import 'package:atma_cinema/models/history_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final historyClientProvider = Provider(
  (ref) => HistoryClient(),
);

final historysFetchActiveProvider =
    FutureProvider<List<HistoryModel>>((ref) async {
  final historyClient = ref.read(historyClientProvider);
  final historys = await historyClient.fetchHistoryOrders();

  return historys.map((history) => HistoryModel.fromJson(history)).toList();
});
