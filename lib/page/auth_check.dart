import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_auth_riverpod/provider/auth/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_page.dart';
import 'login_page.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(streamUser);

    return state.when(
      data: (user) {
        if (user != null) {
          return const HomePage();
        } else {
          return const LoginPage();
        }
      },
      error: (error, stackTrace) => const LoginPage(),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
