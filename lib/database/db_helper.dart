import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/product.dart';

class DBHelper {
  static Database? _db;

  Future<Database> get database async {
    _db ??= await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    final path = join(await getDatabasesPath(), 'product.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, v) async {
        await db.execute('''
          CREATE TABLE product(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            price INTEGER
          )
        ''');
      },
    );
  }

  Future<List<Product>> getAll() async {
    final db = await database;
    final res = await db.query('product');
    return res.map((e) => Product.fromMap(e)).toList();
  }

  Future<void> insert(Product p) async {
    final db = await database;
    await db.insert('product', p.toMap());
  }

  Future<void> update(Product p) async {
    final db = await database;
    await db.update(
      'product',
      p.toMap(),
      where: 'id = ?',
      whereArgs: [p.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await database;
    await db.delete(
      'product',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
