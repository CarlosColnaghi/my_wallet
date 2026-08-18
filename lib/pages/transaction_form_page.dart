import 'package:flutter/material.dart';

class TransactionFormPage extends StatefulWidget {
  @override
  State createState() => TransactionFormState();
}

class TransactionFormState extends State<TransactionFormPage>{
  InputDecoration _inputDecoration(String labelText, String hintText){
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.black),
      floatingLabelStyle: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 20),
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent, width: 2)),
      hintText: hintText,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nova Transação',
          style: TextStyle(
            color: Colors.white
          )
        ),
        backgroundColor: Colors.greenAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: _inputDecoration('Título', 'Ex.: Aluguel, Água, Luz, Gás e etc.'),
            ),
            SizedBox(height: 10,),
            TextField(
                decoration: _inputDecoration('Descrição', 'Ex.: Aluguel referente ao mês de agosto')
            ),
            SizedBox(height: 10,),
            TextField(
              decoration: _inputDecoration('Valor', 'R\$ 0,00')
            ),
            SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent, foregroundColor: Colors.white),
              child: Text('Salvar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
              child: Text('Cancelar'),
            )
          ],
        )
      ),
    );
  }
}