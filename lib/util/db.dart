import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Db{
  String _databaseName = "transactions";
  String _uuid = "uuid";
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
    String path = "${(await getApplicationDocumentsDirectory()).path}_$_databaseName.db";
    return await openDatabase(path, version: 1, onCreate: _create);
  }

  Future<Database> get database async {
    _database ??= await initialize();
    return _database!;
  }

  void _create(Database database, int newVersion) async{
    await database.execute("""
      CREATE TABLE IF NOT EXISTS $_databaseName (
        $_uuid        TEXT PRIMARY KEY NOT NULL DEFAULT (lower(hex(randomblob(16)))),
        $_name        TEXT NOT NULL,
        $_description TEXT,
        $_value       REAL NOT NULL,
        $_type        TEXT NOT NULL,
        $_createdAt   TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
        $_updatedAt   TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')));
     """);

    await database.execute("""
      CREATE TRIGGER IF NOT EXISTS trg_$_databaseName$_updatedAt
      AFTER UPDATE OF $_name, $_description, $_value, $_type
      ON transactions
      FOR EACH ROW
      BEGIN
          UPDATE $_databaseName
          SET $_updatedAt = strftime('%Y-%m-%dT%H:%M:%fZ', 'now')
          WHERE $_uuid = NEW.$_uuid;
      END;
    """);
  }
}