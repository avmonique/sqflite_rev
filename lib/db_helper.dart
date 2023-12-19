import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_rev/product.dart';

class DbHelper {
  // constants
  static const dbName = "shopping.db";
  static const dbVersion = 1;
  // table constants
  static const tbName = "products";
  static const colId = "id";
  static const colTitle = "title";
  static const colDescription = "description";
  static const colPrice = "price";

  // methods 
  static Future<Database> openDB() async {
    var path = join(await getDatabasesPath(), DbHelper.dbName); 
    var sql = "CREATE TABLE IF NOT EXISTS $tbName ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDescription TEXT, $colPrice DECIMAL(10, 4))";
    var db = await openDatabase(
      path, 
      version: DbHelper.dbVersion,
      onCreate: (db, version) {
        db.execute(sql);
        print("table $tbName created");
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (newVersion <= oldVersion) return;
        db.execute("DROP TABLE IF EXISTS $tbName");
        db.execute(sql);
        print("droppped and recreated");
      }
    );
    return db;
  }

  // static void insertRaw() async {
  //   final db = await openDB();
  //   var id = await db.rawInsert("INSERT INTO products VALUES (NULL, 'pouch bag', 'expensive bag', 5000)");
  //   print("insert id $id");
  // }

  static void insertProduct(Product p) async {
    final db = await openDB();
    var id = await db.insert(
      tbName, 
      p.toMapWithoudId(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('inserted id: $id');
  }

  // static Future<List<Map<String, dynamic>>> fetchRow() async {
  //   final db = await openDB();
  //   return await db.rawQuery('SELECT * FROM $tbName');
  // }

  static Future<List<Map<String, dynamic>>> fetchQuery() async {
    final db = await openDB();
    return await db.query(tbName);
  }

  static void deleteRaw(int id) async {
    final db = await openDB();
    var num = await db.rawDelete('DELETE FROM $tbName WHERE $colId = $id');
    print('deleted $num rows');
  }

  static void updateProduct(Product p) async {
    final db = await openDB();
    db.update(
      tbName, 
      p.toMap(),
      where: '$colId = ?',
      whereArgs: [p.id],
    );
  }
}