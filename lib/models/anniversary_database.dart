import 'package:sary/models/anniversary.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class AnniversaryDatabase {
  static final AnniversaryDatabase _instance = AnniversaryDatabase._init();
  static AnniversaryDatabase get instance => _instance;

  static const String _databaseName = 'AnniversaryDatabase.db';

  static Database? _database;

  AnniversaryDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(_databaseName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableAnniversary (
      ${AnniversaryFields.id} $idType,
      ${AnniversaryFields.name} $textType,
      ${AnniversaryFields.date} $textType
    )
    ''');
  }

  Future<Anniversary> create(Anniversary anniversary) async {
    final db = await instance.database;

    final id = await db.insert(tableAnniversary, anniversary.toJson());
    return anniversary.copy(id: id);
  }

  Future<Anniversary> readAnniversary(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableAnniversary,
      columns: AnniversaryFields.values,
      where: '${AnniversaryFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Anniversary.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Anniversary>> readAllAnniversaries() async {
    final db = await instance.database;

    final result = await db.query(tableAnniversary);

    return result.map((json) => Anniversary.fromJson(json)).toList();
  }

  Future<int> update(Anniversary anniversary) async {
    final db = await instance.database;

    return db.update(
      tableAnniversary,
      anniversary.toJson(),
      where: '${AnniversaryFields.id} = ?',
      whereArgs: [anniversary.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableAnniversary,
      where: '${AnniversaryFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
