// ignore_for_file: avoid_print

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:database_sqlite/models/item.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper.internal();
  DBHelper.internal();

  factory DBHelper() => _instance;

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await setDB();
    return _db;
  }

  setDB() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'bagas.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE item(id INTEGER PRIMARY KEY, kode_barang TEXT, name TEXT, price INTEGER, stok INTEGER)',
    );
    print('DB Created');
  }

  Future<int> saveItem(Item item) async {
    var dbClient = await db;
    int res = await dbClient!.insert('item', item.toMap());
    print('Item saved');
    return res;
  }

  Future<List<Item>> getItem() async {
    var dbClient = await db;
    List<Map> list = await dbClient!.rawQuery("SELECT * FROM item");
    List<Item> itemList = [];
    for (int i = 0; i < list.length; i++) {
      var item = Item(
        list[i]['kode_barang'],
        list[i]['name'],
        list[i]['price'],
        list[i]['stok'],
      );
      item.setItemId(list[i]['id']);
      itemList.add(item);
    }
    return itemList;
  }

  Future<bool> updateItem(Item item) async {
    var dbClient = await db;
    int res = await dbClient!.update(
      'item',
      item.toMap(),
      where: 'id=?',
      whereArgs: <int>[item.id],
    );
    return res > 0 ? true : false;
  }

  Future<int> deleteItem(Item item) async {
    var dbClient = await db;
    int res = await dbClient!.rawDelete(
      'DELETE FROM item WHERE id= ?',
      [item.id],
    );
    return res;
  }
}
