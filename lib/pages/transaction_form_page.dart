import 'package:flutter/material.dart';

class TransactionFormPage extends StatefulWidget {
  @override
  State createState() => TransactionFormState();
}

class TransactionFormState extends State<TransactionFormPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Nova Transação",
            style: TextStyle(
                color: Colors.white
            )
        ),
        backgroundColor: Colors.greenAccent,
      ),
    );
  }
}