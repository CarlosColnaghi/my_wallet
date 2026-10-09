import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_wallet/pages/transaction_list_page.dart';

import 'firebase_options.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  runApp(
      MaterialApp(
        title: 'MyWallet',
        home: TransactionListPage()
      )
  );
}