import 'package:atma_cinema/clients/fnb_client.dart';
import 'package:atma_cinema/models/fnb_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedCategoryProvider = StateProvider<String>((ref) => 'Combo');

final fnbClientProvider = Provider(
  (ref) => FnbClient(),
);

final fnbsFetchFnbProvider = FutureProvider<List<FnbModel>>((ref) async {
  final fnbClient = ref.read(fnbClientProvider);
  final selectedCategory = ref.watch(selectedCategoryProvider);

  final fnbs = await fnbClient.fetchAllFnbs(selectedCategory);

  return fnbs.map((fnb) => FnbModel.fromJson(fnb)).toList();
});
