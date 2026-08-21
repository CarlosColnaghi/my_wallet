import 'package:my_wallet/model/TransactionType.dart';

class Transaction {
  String? _uuid;
  String _name;
  String? _description;
  double _value;
  TransactionType _type;
  DateTime? _createdAt;
  DateTime? _updatedAt;

  Transaction(this._uuid, this._name, this._description,  this._value, this._type, this._createdAt, this._updatedAt);

  Transaction.create(this._name, this._description, this._value, this._type);

  String? get uuid => _uuid;
  String get name => _name;
  String? get description => _description;
  double get value => _value;
  TransactionType get type => _type;
  DateTime? get createdAt => _createdAt;
  DateTime? get updatedAt => _updatedAt;

  set name(String name){
    _name = name;
  }

  set description(String? description){
    _description = description;
  }

  set value(double value){
    _value = value;
  }

  set type(TransactionType type){
    _type = type;
  }

}