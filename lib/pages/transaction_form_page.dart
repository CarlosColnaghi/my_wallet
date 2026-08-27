import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:my_wallet/util/db.dart';
import 'package:sqflite/sqflite.dart';

import 'package:my_wallet/model/transaction.dart' as model;
import '../model/transaction_type.dart';

class TransactionFormPage extends StatefulWidget {
  @override
  State createState() => TransactionFormState();
}

class TransactionFormState extends State<TransactionFormPage> {
  final _currencyFormatter = CurrencyTextInputFormatter.currency(
    locale: 'pt_BR',
    symbol: 'R\$ ',
    decimalDigits: 2,
  );

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
  TextEditingController _titleTextEditingController = TextEditingController();
  TextEditingController _descriptionTextEditingController = TextEditingController();
  TextEditingController _valueTextEditingController = TextEditingController();

  final WidgetStateColor _widgetStateColor = WidgetStateColor.resolveWith((states) {
    if (states.contains(WidgetState.selected)) {
      return Colors.greenAccent;
    }
    return Colors.black;
  });

  TransactionType? _transactionType = TransactionType.income;
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
              inputFormatters: [_currencyFormatter],
              decoration: _inputDecoration('Valor', 'R\$ 0,00'),
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
                _db.insert(model.Transaction.create(_titleTextEditingController.text, _descriptionTextEditingController.text, double.parse(_currencyFormatter.getUnformattedValue().toString()), _transactionType!));
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                foregroundColor: Colors.white,
              ),
              child: Text('Salvar'),
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
