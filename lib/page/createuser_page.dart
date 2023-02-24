import 'package:firestore_auth_riverpod/provider/auth/authentication_provider.dart';
import 'package:firestore_auth_riverpod/provider/crud/crud_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreatePage extends ConsumerStatefulWidget {
  const CreatePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreatePageState();
}

class _CreatePageState extends ConsumerState<CreatePage> {
  Map<String, dynamic> data = {
    'name': 'difta fitrahul',
    'school': 'senior high school',
    'age': 17
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create User')),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              ref
                  .read(crudFirestoreProvider)
                  .addData(ref.watch(streamUser).value!.uid, data)
                  .then((value) => ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(const SnackBar(
                      content: Text("succes add data"),
                      duration: Duration(milliseconds: 400),
                    )))
                  .catchError((error) => ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                        duration: const Duration(milliseconds: 400),
                        content: Text(error))));
            },
            child: const Text('Add User')),
      ),
    );
  }
}
