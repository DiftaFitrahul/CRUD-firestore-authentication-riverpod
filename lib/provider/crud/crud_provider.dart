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
          .set(dataUser)
          .onError((error, stackTrace) => (throw error.toString()));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateData(
      String userId, Map<String, dynamic> dataUser, String dataId) async {
    try {
      await db
          .collection('users')
          .doc(userId)
          .collection('dataUser')
          .doc(dataId)
          .update(dataUser)
          .onError((error, stackTrace) => (throw error.toString()));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteData(String userId, String dataId) async {
    try {
      await db
          .collection('users')
          .doc(userId)
          .collection('dataUser')
          .doc(dataId)
          .delete()
          .onError((error, stackTrace) => (throw error.toString()));
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getData(String userId) async {
    try {
      final data = await db
          .collection('users')
          .doc(userId)
          .collection('dataUser')
          .orderBy('date', descending: true)
          .get()
          .then((value) => value.docs);

      final value = data.map((e) => e.data()).toList();
      print(value[0]['university']);
      return [];
    } catch (e) {
      rethrow;
    }
  }
}

final crudFirestoreProvider = Provider(
  (ref) => CrudOperation(),
);

final readDataProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>(
        (ref, userId) => ref.watch(crudFirestoreProvider).getData(userId));
