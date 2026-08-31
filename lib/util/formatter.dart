import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:intl/intl.dart';

class Formatter{
  Formatter._();

  static final DateFormat _dateFormatter = DateFormat("dd/MM/yyyy 'às' HH:mm");

  static final CurrencyTextInputFormatter _currencyFormatter = CurrencyTextInputFormatter.currency(
    locale: 'pt_BR',
    symbol: 'R\$ ',
    decimalDigits: 2,
  );

  static String formatDate(DateTime date){
    return _dateFormatter.format(date);
  }

  static String formatCurrency(double value){
    return _currencyFormatter.formatDouble(value);
  }

  static CurrencyTextInputFormatter getCurrencyFormatter(){
    return _currencyFormatter;
  }
}