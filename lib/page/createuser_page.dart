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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
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
            ElevatedButton(
                onPressed: () {
                  ref
                      .read(crudFirestoreProvider)
                      .updateData(ref.watch(streamUser).value!.uid, data,
                          "15peCHuvQO9wcHKL7UNv")
                      .then((value) => ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(const SnackBar(
                          content: Text("succes update data"),
                          duration: Duration(seconds: 5),
                        )))
                      .catchError((error) => ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                            duration: const Duration(milliseconds: 400),
                            content: Text(error))));
                },
                child: const Text('Update User')),
            ElevatedButton(
                onPressed: () {
                  ref
                      .read(crudFirestoreProvider)
                      .deleteData(ref.watch(streamUser).value!.uid,
                          '15peCHuvQO9wcHKL7UNvhij')
                      .then((value) => ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(const SnackBar(
                          content: Text("succes delete data"),
                          duration: Duration(milliseconds: 600),
                        )))
                      .catchError((error) => ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                            duration: const Duration(milliseconds: 400),
                            content: Text(error))));
                },
                child: const Text('Delete User')),
          ],
        ),
      ),
    );
  }
}
