import 'package:atma_cinema/clients/user_client.dart';
import 'package:atma_cinema/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userClientProvider = Provider(
  (ref) => UserClient(),
);

final userFetchDataProvider = FutureProvider<UserModel>((ref) async {
  final userClient = ref.read(userClientProvider);
  final json = await userClient.getProfile();

  return UserModel.fromJson(json);
});
