import 'package:flutter_app_final/task_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  DBHelper._();
  static DBHelper dbHelper = DBHelper._();
  static final String databaseName = 'tasksDb.db';
  static final String tableName = 'tasks';
  static final String taskIdColumnName = 'id';
  static final String taskNameColumnName = 'name';
  static final String taskIsCompleteName = 'isComplete';
  Database database;
  Future<Database> initDatabase() async {
    if (database == null) {
      return await createDatabase();
    } else {
      return database;
    }
  }

  Future<Database> createDatabase() async {
    try {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, databaseName);
      Database database = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) {
          db.execute('''CREATE TABLE $tableName(
              $taskIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
              $taskNameColumnName TEXT NOT NULL,
              $taskIsCompleteName INTEGER 
              )''');
        },
      );
      return database;
    } on Exception catch (e) {
      print(e);
    }
  }

  insertNewTask(Task task) async {
    try {
      database = await initDatabase();
      int x = await database.insert(tableName, Task.toMap(task));
      print(x);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<Map>> selectAllTasks() async {
    try {
      database = await initDatabase();
      List<Map> result = await database.query(tableName);
      print(result);
      return result;
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<Map>> selectCompleteTask() async {
    try {
      database = await initDatabase();
      List<Map> result = await database
          .query(tableName, where: '$taskIsCompleteName=?', whereArgs: [1]);
      print(result);
      return result;
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<Map>> selectInCompleteTask() async {
    try {
      database = await initDatabase();
      List<Map> result = await database
          .query(tableName, where: '$taskIsCompleteName=?', whereArgs: [0]);
      print(result);
      return result;
    } on Exception catch (e) {
      print(e);
    }
  }

  deleteTask(int id) async {
    try {
      database = await initDatabase();
      int result =
          await database.delete(tableName, where: '$taskIdColumnName=$id');
      print(result);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future updateTask(Task task) async {
    try {
      database = await initDatabase();
      database.update(tableName, Task.toMap(task),
          where: "$taskIdColumnName=${task.id}");
    } on Exception catch (e) {
      print(e);
    }
  }

}
