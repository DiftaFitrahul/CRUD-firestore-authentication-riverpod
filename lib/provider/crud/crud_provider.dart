import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_auth_riverpod/model/dataUser.dart';
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

  Future<List<DataUser>> getData(String userId) async {
    try {
      final data = await db
          .collection('users')
          .doc(userId)
          .collection('dataUser')
          .orderBy('date')
          .get()
          .then((value) => value.docs)
          .onError((error, stackTrace) => (throw error.toString()));

      final value = data.map((e) => DataUser.fromFirestore(e.data())).toList();
      return value;
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<DataUser>> getDataContinuously(String userId) {
    try {
      final dataUser = db
          .collection('users')
          .doc(userId)
          .collection('dataUser')
          .orderBy('date')
          .snapshots()
          .handleError((e) => (throw e));
      final data = dataUser.map((event) =>
          event.docs.map((e) => DataUser.fromFirestore(e.data())).toList());
      return data;
    } catch (e) {
      rethrow;
    }
  }
}

final crudFirestoreProvider = Provider(
  (ref) => CrudOperation(),
);

final readDataProvider = FutureProvider.family<List<DataUser>, String>(
    (ref, userId) => ref.watch(crudFirestoreProvider).getData(userId));

final readDataStreamProvider = StreamProvider.family<List<DataUser>, String>(
    (ref, arg) => ref.watch(crudFirestoreProvider).getDataContinuously(arg));
