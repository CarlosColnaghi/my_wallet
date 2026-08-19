class Transaction {
  String? _uuid;
  String _name;
  String? _description;
  double _value;
  DateTime? _createdAt;
  DateTime? _updatedAt;

  Transaction(this._uuid, this._name, this._description,  this._value, this._createdAt, this._updatedAt);

  Transaction.create(this._name, this._description,  this._value, {DateTime? createdAt, DateTime? updatedAt}) {
    this._createdAt = createdAt ?? DateTime.now();
    this._updatedAt = updatedAt ?? DateTime.now();
  }
}