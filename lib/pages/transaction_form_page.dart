import 'package:flutter/material.dart';
import 'package:my_wallet/util/db.dart';

import 'package:my_wallet/model/transaction.dart' as model;
import 'package:my_wallet/util/formatter.dart';
import '../model/transaction_type.dart';

class TransactionFormPage extends StatefulWidget {
  model.Transaction? transaction;

  TransactionFormPage(this.transaction, {super.key});

  @override
  State createState() => TransactionFormState();
}

class TransactionFormState extends State<TransactionFormPage> {
  InputDecoration _inputDecoration(String labelText, String hintText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.black),
      floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
        final focused = states.contains(WidgetState.focused);
        return TextStyle(
          color: focused ? Colors.greenAccent : Colors.black,
          fontWeight: focused ? FontWeight.bold : FontWeight.normal,
          fontSize: 20,
        );
      }),
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.greenAccent, width: 2),
      ),
      hintText: hintText,
    );
  }

  Db _db = Db();
  final TextEditingController _titleTextEditingController = TextEditingController();
  final TextEditingController _descriptionTextEditingController = TextEditingController();
  final TextEditingController _valueTextEditingController = TextEditingController();

  final WidgetStateColor _widgetStateColor = WidgetStateColor.resolveWith((states) {
    if (states.contains(WidgetState.selected)) {
      return Colors.greenAccent;
    }
    return Colors.black;
  });

  TransactionType? _transactionType = TransactionType.income;

  @override
  void initState() {
    super.initState();
    final transaction = widget.transaction;
    if(transaction != null){
      _titleTextEditingController.text = transaction.name;
      _descriptionTextEditingController.text = transaction.description!;
      _valueTextEditingController.text = Formatter.formatCurrency(transaction.value).toString();
      _transactionType = transaction.type;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Transação', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.greenAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleTextEditingController,
              decoration: _inputDecoration(
                'Título',
                'Ex.: Aluguel, Água, Luz, Gás e etc.',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _descriptionTextEditingController,
              decoration: _inputDecoration(
                'Descrição',
                'Ex.: Aluguel referente ao mês de agosto',
              ),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _valueTextEditingController,
              keyboardType: TextInputType.number,
              inputFormatters: [Formatter.getCurrencyFormatter()],
              decoration: _inputDecoration('Valor', Formatter.formatCurrency(0.0)),
            ),
            SizedBox(
              height: 50,
              child: RadioGroup<TransactionType>(
                groupValue: _transactionType,
                onChanged: (TransactionType? transactionType) {
                  setState(() {
                    _transactionType = transactionType;
                  });
                },
                child: Row(
                  children: [
                    Flexible(
                      child: RadioListTile(
                        title: Text(TransactionType.income.label.toString()),
                        value: TransactionType.income,
                        fillColor: _widgetStateColor),
                      ),
                    Flexible(
                      child: RadioListTile(
                        title: Text(TransactionType.expense.label.toString()),
                        value: TransactionType.expense,
                        fillColor: _widgetStateColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                _db.insert(model.Transaction.create(_titleTextEditingController.text, _descriptionTextEditingController.text, double.parse(Formatter.getCurrencyFormatter().getUnformattedValue().toString()), _transactionType!));
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                foregroundColor: Colors.white,
              ),
              child: Text('Salvar'),
            ),
            Visibility(
              visible: widget.transaction != null,
              child: ElevatedButton(
                onPressed: (){
                  final transaction = widget.transaction;
                  if(transaction != null){
                    _db.delete(transaction.id!);
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(139, 0, 0, 100),
                  foregroundColor: Colors.white,
                ),
                child: Text('Excluir'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
              child: Text('Cancelar'),
            ),
          ],
        ),
      ),
    );
  }
}
