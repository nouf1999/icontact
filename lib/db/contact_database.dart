import 'package:icontact/model/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ContactsDatabase {
  static final ContactsDatabase instance = ContactsDatabase._init();

  static Database? _database;

  ContactsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('contact.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';

    await db.execute('''
CREATE TABLE $tableContacts ( 
  ${ContactFields.id} $idType, 
  ${ContactFields.isImportant} $boolType,
  ${ContactFields.firstName} $textType,
  ${ContactFields.lastName} $textType,
  ${ContactFields.phoneNumber} $textType,
  ${ContactFields.emailAddress} $textType,
  ${ContactFields.time} $textType
  )
''');
  }

  Future<Contact> create(Contact contact) async {
    final db = await instance.database;

    // final json = contact.toJson();
    // final columns =
    //     '${contactFields.title}, ${contactFields.description}, ${contactFields.time}';
    // final values =
    //     '${json[contactFields.title]}, ${json[contactFields.description]}, ${json[contactFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableContacts, contact.toJson());
    return contact.copy(id: id);
  }

  Future<Contact> readContact(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableContacts,
      columns: ContactFields.values,
      where: '${ContactFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Contact.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Contact>> readAllContacts() async {
    final db = await instance.database;

    final orderBy = '${ContactFields.time} ASC';

    final result = await db.query(tableContacts, orderBy: orderBy);

    return result.map((json) => Contact.fromJson(json)).toList();
  }

  Future<int> update(Contact contact) async {
    final db = await instance.database;

    return db.update(
      tableContacts,
      contact.toJson(),
      where: '${ContactFields.id} = ?',
      whereArgs: [contact.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableContacts,
      where: '${ContactFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
