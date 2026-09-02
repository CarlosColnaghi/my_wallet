import 'package:flutter/material.dart';
import 'package:my_wallet/model/transaction.dart';
import 'package:my_wallet/model/transaction_type.dart';
import 'package:my_wallet/pages/transaction_form_page.dart';
import 'package:my_wallet/util/db.dart';
import 'package:my_wallet/util/formatter.dart';

class TransactionListPage extends StatefulWidget {
  @override
  State createState() => TransactionListState();
}

class TransactionListState extends State<TransactionListPage>{
  final Db _db = Db();
  List<Transaction> transactions = [];
  double total = 0.0;

  @override
  void initState() {
    super.initState();
    _loadListData();
  }

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
            child: ListView.builder(itemCount: transactions.length,  itemBuilder: (BuildContext context, int i) {
              bool isIncome = transactions[i].type == TransactionType.income ? true : false;
              if (i < transactions.length) {
                return Card(
                  elevation: 2.0,
                  child: ListTile(
                    leading: isIncome ? Icon(Icons.arrow_circle_up_rounded, size: 35, color: Colors.green,) : Icon(Icons.arrow_circle_down, size: 35, color: Colors.red,),
                    title: Text(transactions[i].title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(transactions[i].description!),
                        Text(Formatter.formatDate(transactions[i].createdAt!.toLocal())),
                      ],
                    ),
                    trailing: isIncome ? Text(Formatter.formatCurrencyFromDoubleToText(transactions[i].value), style: TextStyle(fontSize: 20)) : Text('- ${Formatter.formatCurrencyFromDoubleToText(transactions[i].value)}', style: TextStyle(fontSize: 20),),
                    onTap: () async {
                      await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return TransactionFormPage(transactions[i]);
                      }));
                      await _loadListData();
                    },
                  )
                );
              }
            }),
          ),
          Padding(
            padding: EdgeInsetsGeometry.directional(start: 20, top: 5, end: 20, bottom: 5),
            child: SizedBox(
              height: 100,
              child: Text(Formatter.formatCurrencyFromDoubleToText(total), style: TextStyle(fontSize: 50),),
            ),
          )
      ],),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        await Navigator.push(context, MaterialPageRoute(builder: (context){
          return TransactionFormPage(null);
        }));
        await _loadListData();
      },
      backgroundColor: Colors.greenAccent,
      foregroundColor: Colors.white,
      child: Icon(Icons.add),),
    );
  }

  Future<void> _loadListData() async{
    _db.get().then((list) => {
      setState(() {
        transactions =  list.map((it) => Transaction.fromMap(it)).toList();
        total = transactions.fold(0.0, (sum, transaction) =>  transaction.type == TransactionType.income ? sum + transaction.value : sum - transaction.value);
      })
    });
  }

}