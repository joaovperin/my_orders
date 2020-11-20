import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbUtils {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    // Defines a function to restart the database
    final Function restartDbFunction = (db) => Future.wait([
          ..._dropTablesIfExists(),
          ..._createTables(),
          ..._insertDummyData(),
        ].map(
          (sqlCommand) => db.execute(sqlCommand),
        ));
    // Open the database
    return sql.openDatabase(
      path.join(dbPath, 'banco.db'),
      version: 16,
      // onUpgrade, drop and create tables
      onUpgrade: (db, oldVersion, newVersion) => restartDbFunction.call(db),
      // onCreate, just create tables
      onCreate: (db, version) => restartDbFunction.call(db),
    );
  }

  static List<String> _dropTablesIfExists() {
    return [
      'DROP TABLE IF EXISTS [user]',
      'DROP TABLE IF EXISTS [order_item]',
      'DROP TABLE IF EXISTS [order]',
      'DROP TABLE IF EXISTS [product]',
      'DROP TABLE IF EXISTS [customer]',
    ];
  }

  static List<String> _createTables() {
    return [
      '''CREATE TABLE [user] (
                id INTEGER PRIMARY KEY,
                name TEXT,
                email TEXT,
                password TEXT,
                picture TEXT
            )''',
      '''CREATE TABLE [customer] (
                id INTEGER PRIMARY KEY,
                name TEXT,
                email TEXT,
                phone TEXT,
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
                orderId INTEGER,
                sequence INTEGER,
                productId INTEGER,
                quantity REAL,
                value REAL
            )''',
      '''CREATE TABLE [order] (
                id INTEGER PRIMARY KEY,
                customerId INTEGER,
                entryDate INTEGER,
                totalValue REAL
            )''',
    ];
  }

  static List<String> _insertDummyData() {
    return [
      // Users
      r'''INSERT INTO [user] (name, email, password, picture) VALUES
      ('Judith Harvey', 'judith.harvey@example.com', 'merlin1', 'https://randomuser.me/api/portraits/women/68.jpg'),
      ('Levi Hayes', 'levi.hayes@example.com', 'plymouth', 'https://randomuser.me/api/portraits/men/19.jpg'),
      ('Cory Burke', 'cory.burke@example.com', 'johnny5', NULL),
      ('Colleen Washington', 'colleen.washington@example.com', 'beethove', 'https://randomuser.me/api/portraits/women/90.jpg'),
      ('Alex Reed', 'alex.reed@example.com', 'magnum', 'https://randomuser.me/api/portraits/women/60.jpg')''',
      // Customers
      r'''INSERT INTO [customer] (name, email, phone, address) VALUES
      ('Carmen Oliver', 'carmen.oliver@example.com', NULL, '9637 E Sandy Lake Rd'),
      ('Russell Mitchelle', 'russell.mitchelle@example.com', NULL, '12 Adams St'),
      ('Isobel Alexander', 'isobel.alexander@example.com', NULL, '8328 White Oak Dr'),
      ('Adam Palmer', 'adam.palmer@example.com', NULL, '320 Plum St'),
      ('Jack Hart', 'jack.hart@example.com', NULL, '995 Spring Hill Rd'),
      ('Tammy Wells', 'tammy.wells@example.com', NULL, '7666 E Little York Rd'),
      ('Franklin Andrews', 'franklin.andrews@example.com', NULL, '8965 Mcgowen St'),
      ('Ben Morales', 'ben.morales@example.com', NULL, '4053 Homestead Rd'),
      ('Eileen Torres', 'elen.torres@example.com', NULL, '4871 Spring St')''',
      // Products
      r'''INSERT INTO [product] (description, reference, value) VALUES
      ('Chocolate Cake', 'Good Chocolate Cake', 10.32),
      ('Strawberry Cake', 'Gross Strawberry Cake', 10.32),
      ('Gum', 'BubbleGum', 0.20),
      ('Potato', 'Potato for everyone', 3.19),
      ('Beer', 'Simple pilsen Beer', 3.99),
      ('Lagger Beer', 'A Good Beer', 4.99),
      ('Car', 'A last generation car', 89900),
      ('Bike', 'A small bike', 659.90),
      ('PlayStatlon X5', 'A video game', 3780.00)''',
      // Orders
      r'''INSERT INTO [order] (id, customerId, entryDate, totalValue) VALUES
      (1, 1, 1605906713783, .60),
      (2, 3, 1605908350521, 43.89),
      (3, 4, 1605908350521, 19559.9)''',
      // Order Items
      r'''INSERT INTO [order_item] (orderId, sequence, productId, quantity, value) VALUES
      (1, 1, 3, 3, .20),
      (2, 1, 3, 20, .20), (2, 2, 5, 6, 3.99), (2, 3, 4, 5, 3.19),
      (3, 1, 9, 6, 3780), (3, 2, 8, 1, 659.90)
      ''',
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
