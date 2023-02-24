import 'package:firestore_auth_riverpod/page/createuser_page.dart';
import 'package:firestore_auth_riverpod/provider/auth/authentication_provider.dart';
import 'package:firestore_auth_riverpod/provider/crud/crud_provider.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ref.watch(readDataProvider(ref.watch(streamUser).value!.uid)).when(
                data: (data) => SizedBox(
                      height: 400,
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) =>
                            Text(data[index].keys.toString() ?? ''),
                      ),
                    ),
                error: (error, stackTrace) => Text('data'),
                loading: () => const CircularProgressIndicator()),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreatePage(),
                      ));
                },
                child: const Text('go to create user page')),
            Text(" the Id : ${ref.watch(streamUser).value?.uid ?? 'null'}"),
          ],
        ),
      ),
    );
  }
}
