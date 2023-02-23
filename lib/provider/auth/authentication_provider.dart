import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_auth_riverpod/service/authentication_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authenticationProvider = Provider(
  (ref) => AuthenticationService(),
);

final streamUser = StreamProvider.autoDispose<User?>(
  (ref) => ref.read(authenticationProvider).stateUser,
);

class AuthenticationState extends StateNotifier<bool> {
  AuthenticationState(this.ref) : super(false);
  final Ref ref;
  Future<void> signIn(String email, String password) async {
    try {
      state = true;
      await ref.read(authenticationProvider).signIn(email, password);
      state = false;
    } catch (e) {
      state = false;
      rethrow;
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      state = true;
      await ref.read(authenticationProvider).signUp(email, password);
      state = false;
    } catch (e) {
      state = false;
      rethrow;
    }
  }
}

final authStateProvider = StateNotifierProvider<AuthenticationState, bool>(
    (ref) => AuthenticationState(ref));
