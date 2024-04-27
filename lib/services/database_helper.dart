import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trackjob2024/models/tags.dart';
import 'package:trackjob2024/models/word.dart';

class DatabaseHelper {
  static const _databaseName = "my_database.db";
  static const _databaseVersion = 1;
  static const wordTable = 'word_table';
  static const tagTable = 'tag_table';
  static const tableList = {'word': "word_table", 'tag': "tag_table"};

  DatabaseHelper._internal() {
    _database = _initDatabase();
  }
  static final DatabaseHelper _ = DatabaseHelper._internal();

  static Future<Database>? _database;

  // Future<Database> get database async {
  //   if (_database != null) {
  //     return _database;
  //   }
  //   _database = await _initDatabase();
  //   return _database;
  // }
  factory DatabaseHelper() {
    return _;
  }

  Future<Database> _initDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $wordTable (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            term TEXT NOT NULL,
            definition TEXT NOT NULL,
            tags TEXT,
            judge1 INTEGER NOT NULL,
            judge2 INTEGER NOT NULL,
            isMemorized INTEGER NOT NULL
          )
          ''');
    await db.execute('''
    CREATE TABLE $tagTable (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      countTrue INTEGER,
      countFalse INTEGER,
      isMemorized INTEGER NOT NULL
    )
  ''');
  }
  // CRUD操作

  // データの保存
  Future<int> insertData(String table, Object data) async {
    Database db = await _database!;
    if (table == 'word') {
      data = data as Word;
      return await db.insert(wordTable, data.toMap());
    } else if (table == 'tag') {
      data = data as Tags;
      return await db.insert(tagTable, data.toMap());
    } else {
      return 0;
    }
  }

  // データの取得
  // Future<Word?> queryWord(int id) async {
  //   Database db = await _database!;
  //   List<Map> maps = await db.query(table,
  //       columns: [
  //         'id',
  //         'term',
  //         'definition',
  //         'tags',
  //         'judge1',
  //         'judge2',
  //         'isMemorized'
  //       ],
  //       where: 'id = ?',
  //       whereArgs: [id]);
  //   if (maps.isNotEmpty) {
  //     return Word.fromMap(maps.first as Map<String, dynamic>);
  //   }
  //   return null;
  // }
  // データの取得
  Future<Object?> queryData(String table, int id) async {
    Database db = await _database!;
    if (table == 'word') {
      List<Map> maps = await db.query(wordTable,
          columns: [
            'id',
            'term',
            'definition',
            'tags',
            'judge1',
            'judge2',
            'isMemorized'
          ],
          where: 'id = ?',
          whereArgs: [id]);
      if (maps.isNotEmpty) {
        return Word.fromMap(maps.first as Map<String, dynamic>);
      }
    } else if (table == 'tag') {
      List<Map> maps = await db.query(tagTable,
          columns: ['id', 'name', 'countTrue', 'countFalse', 'isMemorized'],
          where: 'id = ?',
          whereArgs: [id]);
      if (maps.isNotEmpty) {
        return Tags.fromMap(maps.first as Map<String, dynamic>);
      }
    }
    return null;
  }

  // データの更新
  Future<int> updateData(String table, Object data) async {
    Database db = await _database!;
    if (table == 'word') {
      data = data as Word;
      return await db.update(wordTable, data.toMap(),
          where: 'id = ?', whereArgs: [data.id]);
    } else if (table == 'tag') {
      data = data as Tags;
      return await db.update(tagTable, data.toMap(),
          where: 'id = ?', whereArgs: [data.id]);
    }
    return 0;
  }

  // データの削除
  Future<int> deleteData(String table, int id) async {
    Database db = await _database!;
    if (table == 'word') {
      return await db.delete(wordTable, where: 'id = ?', whereArgs: [id]);
    } else if (table == 'tag') {
      return await db.delete(tagTable, where: 'id = ?', whereArgs: [id]);
    }
    return 0;
  }

  // 全データの取得
  Future<List<Object>> queryAllData(String table) async {
    Database db = await _database!;
    if (table == 'word') {
      List<Map> maps = await db.query(wordTable);
      if (maps.isNotEmpty) {
        return List.generate(maps.length, (i) {
          return Word.fromMap(maps[i] as Map<String, dynamic>);
        });
      }
    } else if (table == 'tag') {
      List<Map> maps = await db.query(tagTable);
      if (maps.isNotEmpty) {
        return List.generate(maps.length, (i) {
          return Tags.fromMap(maps[i] as Map<String, dynamic>);
        });
      }
    }
    return [];
  }
}
