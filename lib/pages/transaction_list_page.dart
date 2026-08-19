import 'package:flutter/material.dart';
import 'package:my_wallet/pages/transaction_form_page.dart';

class TransactionListPage extends StatefulWidget {
  @override
  State createState() => TransactionListState();
}

class TransactionListState extends State<TransactionListPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transações',
          style: TextStyle(
            color: Colors.white
          )
        ),
        backgroundColor: Colors.greenAccent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(itemBuilder: (BuildContext context, int i) {
              if (i < 10) {
                return Card(
                  elevation: 2.0,
                  child: ListTile(
                    leading: i%2 == 0 ? Icon(Icons.arrow_circle_up_rounded, size: 35, color: Colors.green,) : Icon(Icons.arrow_circle_down, size: 35, color: Colors.red,),
                    title: Text('Lorem Ipsum'),
                    subtitle: Text('Lorem Ipsum'),
                    trailing: i%2 == 0 ? Text('R\$10.00', style: TextStyle(fontSize: 20)) : Text('- R\$10.00', style: TextStyle(fontSize: 20),),
                  )
                );
              }
            }),
          ),
          Padding(
            padding: EdgeInsetsGeometry.directional(start: 20, top: 5, end: 20, bottom: 5),
            child: SizedBox(
              height: 100,
              child: Text("R\$ 0.00", style: TextStyle(fontSize: 50),),
            ),
          )
      ],),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return TransactionFormPage();
        }));
      },
      backgroundColor: Colors.greenAccent,
      foregroundColor: Colors.white,
      child: Icon(Icons.add),),
    );
  }
}