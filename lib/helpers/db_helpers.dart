import 'dart:ffi';

import 'package:aidaly/models/Role/ShopperModel/product_details_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import '../models/add_to_cart_model.dart';

class DBHelper {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database;
  }

  initDatabase() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'cart.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

// creating database table
  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE cart(id INTEGER PRIMARY KEY AUTOINCREMENT, productId VARCHAR UNIQUE,productName TEXT, productPrice INTEGER, quantity INTEGER,productSize TEXT,productColor TEXT, image TEXT)');
  }

// inserting data into the table
  Future<Cart> insert(Cart cart) async {
    var dbClient = await database;
    await dbClient!.insert('cart', cart.toMap());
    return cart;
  }

// getting all the items in the list from the database
  Future<List<Cart>> getCartList() async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('cart');
    return queryResult.map((result) => Cart.fromMap(result)).toList();
  }



  Future<int> updateQuantity(Cart cart) async {
    var dbClient = await database;
    return await dbClient!.update('cart', cart.toMap(),
        where: "productId = ?", whereArgs: [cart.productId]);
  }

// deleting an item from the cart screen
  Future<int> deleteCartItem(int id) async {
    var dbClient = await database;
    return await dbClient!.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  Future deleteTable(String tableName) async {
    var dbClient = await database;
    await dbClient!.delete(tableName);
  }
}
