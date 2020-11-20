import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbUtils {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();

    return sql.openDatabase(
      path.join(dbPath, 'banco.db'),
      version: 9,
      // onUpgrade, drop and create tables
      onUpgrade: (db, oldVersion, newVersion) {
        return Future.wait([
          ..._dropTables().map(
            (sqlCommand) => db.execute(sqlCommand),
          ),
          ..._createTables().map(
            (sqlCommand) => db.execute(sqlCommand),
          )
        ]);
      },
      // onCreate, just create tables
      onCreate: (db, version) {
        return Future.wait(_createTables().map(
          (sqlCommand) => db.execute(sqlCommand),
        ));
      },
    );
  }

  static List<String> _dropTables() {
    return [
      'DROP TABLE IF EXISTS [order_item]',
      'DROP TABLE IF EXISTS [order]',
      'DROP TABLE IF EXISTS [product]',
      'DROP TABLE IF EXISTS [customer]',
    ];
  }

  static List<String> _createTables() {
    return [
      '''CREATE TABLE [customer] (
                id INTEGER PRIMARY KEY,
                name TEXT,
                address TEXT
            )''',
      '''CREATE TABLE [product] (
                id INTEGER PRIMARY KEY,
                description TEXT,
                reference TEXT,
                value REAL
            )''',
      '''CREATE TABLE [order_item] (
                id INTEGER PRIMARY KEY,
                order_id INTEGER,
                sequence INTEGER,
                product_id INTEGER,
                quantity REAL,
                value REAL
            )''',
      '''CREATE TABLE [order] (
                id INTEGER PRIMARY KEY,
                customer_id INTEGER,
                entry_date INTEGER,
                total_value REAL
            )''',
    ];
  }

  static Future<int> insert(String table, Map<String, Object> data) async {
    final db = await DbUtils.database();
    data['id'] = null; // clear rowid
    return await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.rollback,
    );
  }

  static Future<void> delete(String table, int id) async {
    final db = await DbUtils.database();
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> query(String table, {String where, List<dynamic> args}) async {
    final db = await DbUtils.database();
    return db.query(table, where: where, whereArgs: args);
  }
}
