import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:trackjob2024/models/word.dart';


class DatabaseHelper {
  static const _databaseName = "my_database.db";
  static const _databaseVersion = 1;
  static const table = 'word_table';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static late Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            term TEXT NOT NULL,
            definition TEXT NOT NULL,
            tags TEXT,
            isMemorized INTEGER NOT NULL
          )
          ''');
  }
   // CRUD操作
  Future<int> insertWord(Word word) async {
    Database db = await database;
    return await db.insert(table, word.toMap());
  }
  Future<Word?> queryWord(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(table,
        columns: ['id', 'term', 'definition', 'tags', 'isMemorized'],
        where: 'id = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Word.fromMap(maps.first as Map<String, dynamic>);
    }
    return null;
  }
  Future<int> updateWord(Word word) async {
    Database db = await database;
    return await db
        .update(table, word.toMap(), where: 'id = ?', whereArgs: [word.id]);
  }
  Future<int> deleteWord(int id) async {
    Database db = await database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}