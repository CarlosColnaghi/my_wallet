import 'package:flutter/material.dart';
import 'package:my_wallet/model/wallet_transaction.dart';
import 'package:my_wallet/model/wallet_transaction_type.dart';
import 'package:my_wallet/pages/transaction_form_page.dart';
import 'package:my_wallet/util/db.dart';
import 'package:my_wallet/util/formatter.dart';

class TransactionListPage extends StatefulWidget {
  @override
  State createState() => TransactionListState();
}

class TransactionListState extends State<TransactionListPage>{
  final Db _db = Db();
  double total = 0.0;

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
      body: StreamBuilder<List<WalletTransaction>> (
        stream: _db.getStream(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(color: Colors.greenAccent,),);
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}', style: TextStyle(fontSize: 20, color: Colors.grey.shade800)));
          }
          List<WalletTransaction> transactions = snapshot.data ?? [];
          total = transactions.fold(0.0, (sum, transaction) =>  transaction.type == WalletTransactionType.income ? sum + transaction.value : sum - transaction.value);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView.builder(itemCount: transactions.length,  itemBuilder: (BuildContext context, int i) {
                  bool isIncome = transactions[i].type == WalletTransactionType.income ? true : false;
                  if (i < transactions.length) {
                    return Card(
                      elevation: 2.0,
                      child: ListTile(
                        leading: isIncome ? Icon(Icons.arrow_circle_up_rounded, size: 35, color: Colors.green.shade700,) : Icon(Icons.arrow_circle_down, size: 35, color: Colors.red.shade700,),
                        title: Text(transactions[i].title),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(transactions[i].description!),
                            Text(Formatter.formatDate(transactions[i].createdAt!.toLocal())),
                          ],
                        ),
                        trailing: isIncome ? Text(Formatter.formatCurrencyFromDoubleToText(transactions[i].value), style: TextStyle(fontSize: 20, color: Colors.green.shade700)) : Text('- ${Formatter.formatCurrencyFromDoubleToText(transactions[i].value)}', style: TextStyle(fontSize: 20, color: Colors.red.shade700),),
                        onTap: () async {
                          await Navigator.push(context, MaterialPageRoute(builder: (context){
                            return TransactionFormPage(transactions[i]);
                          }));
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
                  child: Text(Formatter.formatCurrencyFromDoubleToText(total), style: TextStyle(fontSize: 50, color: total > 0 ? Colors.green.shade700 : total < 0 ? Colors.red.shade700 : Colors.grey.shade800),),
                ),
              )
            ],
          );
        }
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        await Navigator.push(context, MaterialPageRoute(builder: (context){
          return TransactionFormPage(null);
        }));
      },
      backgroundColor: Colors.greenAccent,
      foregroundColor: Colors.white,
      child: Icon(Icons.add),),
    );
  }
}