import 'package:atma_cinema/clients/promo_client.dart';
import 'package:atma_cinema/models/promo_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final promoClientProvider = Provider(
  (ref) => PromoClient(),
);

final promosFetchFnbProvider = FutureProvider<List<PromoModel>>((ref) async {
  final promoClient = ref.read(promoClientProvider);
  final promos = await promoClient.fetchFnbPromos();

  return promos.map((promo) => PromoModel.fromJson(promo)).toList();
});

final promosFetchGeneralProvider =
    FutureProvider<List<PromoModel>>((ref) async {
  final promoClient = ref.read(promoClientProvider);
  final promos = await promoClient.fetchGeneralPromos();
  print(promos);

  return promos.map((promo) => PromoModel.fromJson(promo)).toList();
});
