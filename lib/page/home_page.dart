import 'package:firestore_auth_riverpod/provider/auth/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        leading: IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authenticationProvider).signOut();
            }),
      ),
      body: Center(
        child: Text(" the Id : ${ref.watch(streamUser).value?.uid ?? 'null'}"),
      ),
    );
  }
}
