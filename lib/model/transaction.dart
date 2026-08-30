import 'package:my_wallet/model/transaction_type.dart';

class Transaction {
  int? _id;
  String? _transactionId;
  String _name;
  String? _description;
  double _value;
  TransactionType _type;
  DateTime? _createdAt;
  DateTime? _updatedAt;

  Transaction(this._id, this._transactionId, this._name, this._description,  this._value, this._type, this._createdAt, this._updatedAt);

  Transaction.create(this._name, this._description, this._value, this._type);

  int? get id => _id;
  String? get transactionId => _transactionId;
  String get name => _name;
  String? get description => _description;
  double get value => _value;
  TransactionType get type => _type;
  DateTime? get createdAt => _createdAt;
  DateTime? get updatedAt => _updatedAt;

  Map<String, dynamic> toMap(){
    return {
      'name': _name,
      'description': _description,
      'value': _value,
      'type': _type.label
    };
  }

  Transaction.fromMap(Map<String, dynamic> map) :
    _id = map['id'] as int?,
    _transactionId = map['transactionId'],
    _name = map['name'],
    _description = map['description'],
    _value = map['value'].toDouble(),
    _type = TransactionType.values.firstWhere((type) => type.label == map['type']),
    _createdAt = DateTime.parse(map['createdAt']),
    _updatedAt = DateTime.parse(map['updatedAt']);


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