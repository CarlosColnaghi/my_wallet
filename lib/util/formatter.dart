import 'dart:ffi';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:intl/intl.dart';

class Formatter{
  Formatter._();

  static final DateFormat _dateFormatter = DateFormat("dd/MM/yyyy 'às' HH:mm");

  static final CurrencyTextInputFormatter _currencyTextInputFormatter = CurrencyTextInputFormatter.currency(
    locale: 'pt_BR',
    symbol: 'R\$ ',
    decimalDigits: 2,
  );

  static final NumberFormat _currencyNumberFormatter = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$ ',
    decimalDigits: 2,
  );

  static String formatDate(DateTime date){
    return _dateFormatter.format(date);
  }

  static String formatCurrencyFromDoubleToText(double value){
    return _currencyNumberFormatter.format(value);
  }

  static double formatCurrencyFromTextToDouble(String value){
    return _currencyNumberFormatter.parse(value).toDouble();
  }

  static CurrencyTextInputFormatter getCurrencyTextInputFormatter(){
    return _currencyTextInputFormatter;
  }
}