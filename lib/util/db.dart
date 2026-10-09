import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_wallet/model/wallet_transaction.dart';

class Db{
  Db._internal();
  static final Db _db = Db._internal();

  factory Db() => _db;

  final _instance = FirebaseFirestore.instance.collection("mywallet");

  Future<DocumentReference> insert(WalletTransaction transaction) async {
    final data = transaction.toMap();
    data['createdAt'] = DateTime.now();
    data['updatedAt'] = DateTime.now();
    return await _instance.add(data);
  }

  Future<void> update(WalletTransaction transaction, String id) async{
    final data = transaction.toMap();
    data['updatedAt'] = DateTime.now();
    await _instance.doc(id).update(data);
  }

  Stream<List<WalletTransaction>> getStream() => _instance.snapshots().map((snapshot) => snapshot.docs.map((document) => WalletTransaction.fromDocumentSnapshot(document)).toList());

  Future<void> delete(String id) async => await _instance.doc(id).delete();

}