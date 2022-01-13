import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:product_list/data/models/product.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "product_list.db";
  static const _databaseVersion = 1;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Database? _database;

  Future<Database> get database async {
    // ignore: unnecessary_null_comparison
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDb();
    return _database!;
  }

  _initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE ${Product.tableName}(
            id            TEXT      PRIMARY KEY, 
            name          TEXT      NOT NULL,
            description   TEXT      NOT NULL,
            price         TEXT      NOT NULL,
            image         TEXT      NOT NULL,
            isOnWishlist  INTEGER   NOT NULL
          )
          ''');
  }
}
