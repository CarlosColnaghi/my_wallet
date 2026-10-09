import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_wallet/model/wallet_transaction_type.dart';

class WalletTransaction {
  String? _id;
  String _title;
  String? _description;
  double _value;
  WalletTransactionType _type;
  DateTime? _createdAt;
  DateTime? _updatedAt;

  WalletTransaction(this._id, this._title, this._description,  this._value, this._type, this._createdAt, this._updatedAt);

  WalletTransaction.create(this._title, this._description, this._value, this._type);

  String? get id => _id;
  String get title => _title;
  String? get description => _description;
  double get value => _value;
  WalletTransactionType get type => _type;
  DateTime? get createdAt => _createdAt;
  DateTime? get updatedAt => _updatedAt;

  Map<String, dynamic> toMap(){
    return {
      'title': _title,
      'description': _description,
      'value': _value,
      'type': _type.label
    };
  }

  WalletTransaction.fromMap(Map<String, dynamic> map) :
    _id = map['id'],
    _title = map['title'],
    _description = map['description'],
    _value = map['value'].toDouble(),
    _type = WalletTransactionType.fromString(map['type']),
    _createdAt = DateTime.parse(map['createdAt']),
    _updatedAt = DateTime.parse(map['updatedAt']);

  WalletTransaction.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc):
      _id = doc.id,
      _title = doc.data()?['title'],
      _description = doc.data()?['description'],
      _value = (doc.data()?['value']).toDouble(),
      _type = WalletTransactionType.fromString(doc.data()?['type']),
      _createdAt = (doc.data()?['createdAt'] as Timestamp?)?.toDate(),
      _updatedAt = (doc.data()?['updatedAt'] as Timestamp?)?.toDate();


  set title(String title){
    _title = title;
  }

  set description(String? description){
    _description = description;
  }

  set value(double value){
    _value = value;
  }

  set type(WalletTransactionType type){
    _type = type;
  }
}