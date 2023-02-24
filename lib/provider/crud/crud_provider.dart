import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CrudOperation {
  final db = FirebaseFirestore.instance;

  Future<void> addData(String userId, Map<String, dynamic> dataUser) async {
    try {
      await db
          .collection('users')
          .doc(userId)
          .collection('dataUser')
          .doc()
          .set(dataUser, SetOptions(merge: true));
    } catch (e) {
      rethrow;
    }
  }
}

final crudFirestoreProvider = Provider(
  (ref) => CrudOperation(),
);
