import 'package:flutter/material.dart';

class TransactionListPage extends StatefulWidget {
  @override
  State createState() => TransactionListPageState();
}

class TransactionListPageState extends State<TransactionListPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Transações",
          style: TextStyle(
            color: Colors.white
          )
        ),
        backgroundColor: Colors.greenAccent,
      ),
      body: ListView.builder(itemBuilder: (BuildContext context, int i) {
        if (i < 10) {
          return Card(
            elevation: 2.0,
            child: ListTile(
              leading: i%2 == 0 ? Icon(Icons.arrow_circle_up_rounded, size: 35, color: Colors.green,) : Icon(Icons.arrow_circle_down, size: 35, color: Colors.red,),
              title: Text("Lorem Ipsum"),
              subtitle: Text("Lorem Ipsum"),
              trailing: i%2 == 0 ? Text("R\$10.00", style: TextStyle(fontSize: 20)) : Text("- R\$10.00", style: TextStyle(fontSize: 20),),
            )
          );
        }
      }),
      floatingActionButton: FloatingActionButton(onPressed: (){
      },
      backgroundColor: Colors.greenAccent,
      foregroundColor: Colors.white,
      child: Icon(Icons.add),),
    );
  }
}