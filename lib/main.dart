import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_wallet/pages/transaction_list_page.dart';

import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      MaterialApp(
        title: 'MyWallet',
        home: TransactionListPage()
      )
  );
}