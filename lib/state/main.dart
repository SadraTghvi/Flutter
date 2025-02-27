import 'package:flutter_application_1/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final helloWorldProvider = StateProvider<int>((ref) => 0);

class SelfState extends StateNotifier<SelfModel> {
  SelfState()
      : super(SelfModel(
          loading: true,
          fetch: false,
          user: null,
          guest: false,
          login: false,
        ));

  void update({bool? loading, bool? fetch, bool? guest, bool? login, UserModel? user}) {
    state = state.copyWith(
      loading: loading ?? state.loading,
      fetch: fetch ?? state.fetch,
      guest: guest ?? state.guest,
      login: login ?? state.login,
      user: user ?? state.user,
    );
  }
}

final selfProvider = StateNotifierProvider<SelfState, SelfModel>((ref) {
  return SelfState();
});
