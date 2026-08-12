import 'package:flutter/material.dart';

class TransactionListPage extends StatefulWidget {
  @override
  State createState() => TransactionListPageState();
}

class TransactionListPageState extends State<TransactionListPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transações'))
    );
  }
}