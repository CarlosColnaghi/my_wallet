import 'package:flutter/material.dart';
import 'package:my_wallet/pages/transaction_list_page.dart';

void main() {
  runApp(
      MaterialApp(
        title: 'MyWallet',
        home: TransactionListPage()
      )
  );
}