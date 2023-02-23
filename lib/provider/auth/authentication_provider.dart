import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_auth_riverpod/service/authentication_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authenticationProvider = Provider(
  (ref) => AuthenticationService(),
);

final streamUser = StreamProvider.autoDispose<User?>(
  (ref) => ref.read(authenticationProvider).stateUser,
);
