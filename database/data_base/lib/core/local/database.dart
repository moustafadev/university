import 'dart:io';

import 'package:data_base/model/executors_model.dart';
import 'package:data_base/model/order_model.dart';
import 'package:data_base/model/service_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../model/user_model.dart';

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

   // DBProvider.db.deleteDatabase(path);

    return await openDatabase(path,
        version: 1, onOpen: (db) {}, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      create table User ( 
        user_id integer primary key autoincrement, 
        first_name text not null,
        last_name text not null,
        email integer not null,
        phone_user integer not null,
        address_user integer not null
        )
     ''');

    await db.execute('''  
    CREATE TABLE Service (
      service_id INTEGER PRIMARY KEY autoincrement,
      name_service TEXT NOT NULL,
      price DOUBLE NOT NULL
     )''');

    await db.execute('''  
    CREATE TABLE Executors (
      executors_id INTEGER PRIMARY KEY autoincrement,
      work_experience TEXT NOT NULL,
      phone_executors TEXT NOT NULL UNIQUE,
      first_name TEXT NOT NULL,
      last_name TEXT NOT NULL,
      email TEXT NOT NULL UNIQUE
     )''');

    await db.execute('''
    CREATE TABLE Orders (
      order_id INTEGER PRIMARY KEY autoincrement,
      date TEXT NOT NULL,
      sum TEXT NOT NULL,
      quantity TEXT NOT NULL,
      paid INTEGER,
      executors_id INTEGER,
      service_id INTEGER,
      user_id INTEGER,
      FOREIGN KEY (user_id) REFERENCES User (user_id),
      FOREIGN KEY (service_id) REFERENCES Service (service_id),
      FOREIGN KEY (executors_id) REFERENCES Executors (executors_id)
     )''');
  }

  Future<UserModel> insertUser(UserModel userModel) async {
    userModel.idUser = await _database!.insert("User", userModel.toMap());
    return userModel;
  }

  Future<bool> insertService(ServiceModel serviceModel) async {
    try {
      serviceModel.idService =
          await _database!.insert("Service", serviceModel.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> insertExecutors(ExecutorsModel executorsModel) async {
    try {
      executorsModel.idExecutors =
          await _database!.insert("Executors", executorsModel.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> insertOrder(OrderModel orderModel) async {
    try {
      orderModel.idOrder =
          await _database!.insert("Orders", orderModel.toMap());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
