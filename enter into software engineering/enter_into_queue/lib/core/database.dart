import 'dart:io';


import 'package:enter_into_queue/presentation/auth/model/queue.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../presentation/auth/model/user.dart';


class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  Future<void> deleteDatabase(String path) =>
      databaseFactory.deleteDatabase(path);

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "ads.db");
    //DBProvider.db.deleteDatabase(path);
    return await openDatabase(path,
        version: 1, onOpen: (db) {}, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      create table User ( 
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        fuo text not null,
        username text not null,
        work text not null,
        password text not null,
        numberWindow text,
        currentWindow text
        )
     ''');

    await db.execute('''
    CREATE TABLE Queue (
      id INTEGER PRIMARY KEY autoincrement,
      number TEXT NOT NULL,
      perQueue TEXT NOT NULL,
      status TEXT NOT NULL
     )''');
  }

  Future<User> insertUser(User userModel) async {
    print(userModel.toJson());
    userModel.id = await _database!.insert("User", userModel.toJson());
    return userModel;
  }

  Future<bool> insertService(Queue queueModel) async {
    try {
      queueModel.id =
      await _database!.insert("Queue", queueModel.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }



}
