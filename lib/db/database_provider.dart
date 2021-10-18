import 'package:icontact/model/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const _databaseName = "contact_database.db";
  static const _databaseVersion = 1;
  static const table = "contact_table";

  static const columnId = 'id';
  static const columnName = 'name';
  static const columnPhone = 'phone';
  static const columnEmail = 'email';
  static const columnLocation = 'location';
  static const columnAvatar = 'avatar';
  static const columnFavorite = 'favorite';

  static final DatabaseProvider instance = DatabaseProvider._init();

  static Database? _database;

  DatabaseProvider._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(_databaseName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  //SQL code to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $table (
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnName TEXT NOT NULL,
          $columnPhone TEXT NOT NULL,
          $columnEmail TEXT NOT NULL,
          $columnLocation TEXT NOT NULL,
          $columnAvatar TEXT,
          $columnFavorite INTEGER NOT NULL
        )
      ''');
  }

  //Helper methods

  Future<int> insert(Contact contact) async {
    Database? db = await instance.database;
    return await db.insert(table, {
      'name': contact.name,
      'phone': contact.phone,
      'email': contact.email,
      'location': contact.location,
      'avatar': contact.avatar,
      'favorite': contact.favorite
    });
  }

  // Get all the data of the table
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.database;
    return await db.query(table, orderBy: columnName);
  }

  Future<List<Map<String, dynamic>>> queryRows(text) async {
    Database? db = await instance.database;
    return await db.query(table,
        where: "$columnName LIKE ? OR $columnPhone LIKE ?",
        whereArgs: [text, text]);
  }

  Future<List<Map<String, dynamic>>> queryFavoriteContacts() async {
    Database? db = await instance.database;
    return await db.query(table, where: "$columnFavorite = ?", whereArgs: [1]);
  }

  Future<int?> queryRowCount() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM $table"));
  }

  Future<int> update(Contact contact) async {
    Database? db = await instance.database;
    int id = contact.toMap()['id'];
    return await db.update(table, contact.toMap(),
        where: "$columnId = ?", whereArgs: [id]);
  }

  Future<int> addToFavorite(Contact contact) async {
    Database? db = await instance.database;
    int id = contact.toMap()["id"];
    return await db
        .rawUpdate('UPDATE $table SET favorite = ? WHERE id = ?', [1, id]);
  }

  Future<int> removeFromFavorite(Contact contact) async {
    Database? db = await instance.database;
    int id = contact.toMap()["id"];
    return await db
        .rawUpdate('UPDATE $table SET favorite = ? WHERE id = ?', [0, id]);
  }

  Future<int> delete(int id) async {
    Database? db = await instance.database;

    return db.delete(table, where: "$columnId = ?", whereArgs: [id]);
  }
}
