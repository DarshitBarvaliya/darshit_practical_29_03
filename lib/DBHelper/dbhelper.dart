import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/TodoModel.dart';
import '../Utils/ConsoleLog.dart';

class DatabaseHandler {
  ///create database
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'todoDatabase.db'),
      onCreate: createDatabase,
      version: 1,
    );
  }

  Future<void> createDatabase(Database database, int version) async {
    Console.Log('SQLDatabase', 'Database Created');

    String incomeTable =
        "CREATE TABLE todo(id INTEGER PRIMARY KEY, title TEXT,date TEXT ,category TEXT,isUpdated TEXT)";

    await database.execute(incomeTable);
  }

  ///create tables
  Future<void> insertIncome(TodoModel income) async {
    final db = await initializeDB();
    await db.insert(
      'todo',
      income.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  ///get inserted data
  Future<List<TodoModel>> getTodo() async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> queryResult = await db.query('todo');
    return queryResult.map((e) => TodoModel.fromMap(e)).toList();
  }

  ///get inserted data
  Future<List<TodoModel>> getByCategory({var value}) async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> queryResult =
        await db.query('todo', where: "category =?", whereArgs: [value]);
    return queryResult.map((e) => TodoModel.fromMap(e)).toList();
  }

  ///update data
  Future<void> updateIncome(TodoModel income) async {
    // Get a reference to the database.
    final db = await initializeDB();
    await db.update(
      'todo',
      income.toMap(),
      where: 'id = ?',
      whereArgs: [income.id],
    );
  }

  ///delete data from table
  Future<void> deleteTodo(int id) async {
    final db = await initializeDB();
    await db.delete(
      'todo',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
