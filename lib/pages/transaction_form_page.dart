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
      _valueTextEditingController.text = Formatter.formatCurrencyFromDoubleToText(transaction.value);
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
              inputFormatters: [Formatter.getCurrencyTextInputFormatter()],
              decoration: _inputDecoration('Valor', Formatter.formatCurrencyFromDoubleToText(0.0)),
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
            if(widget.transaction != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Text('Criado em ${Formatter.formatDate(widget.transaction!.createdAt!.toLocal())}', style: TextStyle(fontWeight: FontWeight.w500),),
                  Text('Atualizado em ${Formatter.formatDate(widget.transaction!.updatedAt!.toLocal())}', style: TextStyle(fontWeight: FontWeight.w500),),
                  Text('ID: ${widget.transaction!.transactionId!}', style: TextStyle(fontWeight: FontWeight.w500),),
                ],
              ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                final model.Transaction? transaction = widget.transaction;
                if(transaction != null){
                  _db.update(model.Transaction.create(_titleTextEditingController.text, _descriptionTextEditingController.text,Formatter.formatCurrencyFromTextToDouble(_valueTextEditingController.text), _transactionType!), transaction.id!);
                }else{
                  _db.insert(model.Transaction.create(_titleTextEditingController.text, _descriptionTextEditingController.text, Formatter.formatCurrencyFromTextToDouble(_valueTextEditingController.text), _transactionType!));
                }
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                foregroundColor: Colors.white,
              ),
              child: Text('Salvar'),
            ),
            if(widget.transaction != null)
              ElevatedButton(
                onPressed: () async {
                  final transaction = widget.transaction;
                  if(transaction != null){
                    bool confirmed = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Excluir transação'),
                        content: Text('Deseja excluir a transação?'),
                        actions: [
                          TextButton(
                            onPressed: () => {
                              Navigator.pop(context, false)
                            },
                            child: Text('Cancelar', style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold),),
                          ),
                          TextButton(
                            onPressed: () => {
                              Navigator.pop(context, true)
                            },
                            child: Text('Excluir', style: TextStyle(color: Color.fromRGBO(139, 0, 0, 100), fontWeight: FontWeight.bold),),
                          )
                        ],
                      )
                    );
                    if(confirmed){
                      _db.delete(transaction.id!);
                      Navigator.pop(context);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(139, 0, 0, 100),
                  foregroundColor: Colors.white,
                ),
                child: Text('Excluir'),
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
