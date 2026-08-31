import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:my_wallet/model/transaction.dart' as model;

class Db{
  String _tableName = "transactions";
  String _id = "id";
  String _transactionId = "transactionId";
  String _name = "name";
  String _description = "description";
  String _value = "value";
  String _type = "type";
  String _createdAt = "createdAt";
  String _updatedAt = "updatedAt";

  Db._internal();
  static final Db _db = Db._internal();

  factory Db(){
    return _db;
  }

  static Database? _database;

  Future<Database> initialize() async{
    String path = "${(await getApplicationDocumentsDirectory()).path}_my_wallet.db";
    return await openDatabase(path, version: 1, onCreate: _create);
  }

  Future<Database> get database async {
    _database ??= await initialize();
    return _database!;
  }

  void _create(Database database, int newVersion) async{
    await database.execute("""
      CREATE TABLE IF NOT EXISTS $_tableName (
        $_id            INTEGER PRIMARY KEY,
        $_transactionId TEXT NOT NULL UNIQUE DEFAULT (lower(hex(randomblob(16)))),
        $_name          TEXT NOT NULL,
        $_description   TEXT,
        $_value         REAL NOT NULL,
        $_type          TEXT NOT NULL,
        $_createdAt     TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
        $_updatedAt     TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')));
     """);

    await database.execute("""
      CREATE TRIGGER IF NOT EXISTS trg_$_tableName$_updatedAt
      AFTER UPDATE OF $_name, $_description, $_value, $_type
      ON transactions
      FOR EACH ROW
      BEGIN
          UPDATE $_tableName
          SET $_updatedAt = strftime('%Y-%m-%dT%H:%M:%fZ', 'now')
          WHERE $_id = NEW.$_id;
      END;
    """);
  }

  Future<int> insert(model.Transaction transaction) async => await (await database).insert(_tableName, transaction.toMap());

  Future<List> get() async => await (await database).rawQuery("SELECT * FROM $_tableName ORDER BY $_createdAt ASC");

  Future<int> delete(int id) async => await (await database).rawDelete('DELETE FROM $_tableName WHERE $_id = $id');

}