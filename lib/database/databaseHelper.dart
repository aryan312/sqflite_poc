import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databasename = "person.db";
  static final _databaseversion = 1;

  static final table = "my_table";
  static final columnID = 'id';
  static final columnName = 'name';
  static final columnage = 'age';

  static Database? _database;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance= DatabaseHelper._privateConstructor();

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _initDatabase();
      return _database;
    }
  }

  _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databasename);
    return await openDatabase(path,
        version: _databaseversion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $table ($columnID INTEGER PRIMARY KEY, $columnName TEXT NOT NULL, $columnage INTEGER NOT NULL)');
  }
  //functions to insert update and delete from the table
  Future<int>insert(Map<String,dynamic> row) async{
    Database? db=await instance.database;
    return await db!.insert(table,row);
  }
  //query all rows
  Future<List<Map<String,dynamic>>> queryAll() async{
    Database? db=await instance.database;
    return await db!.query(table);
  }

  Future<List<Map<String,dynamic>>> querySpecific(int age) async{
    Database? db=await instance.database;
    var res=await db!.query(table,where: "age > ?", whereArgs: [age]);
    return res;
  }
  
  Future<int> deleteData(int id)async{
    Database? db=await instance.database;
    var res= await db!.delete(table,where: "id = ?", whereArgs: [id]);
    return res;
  }

  Future<int> update(int id)async{
    Database? db=await instance.database;
    var res= await db!.update(table,{"name": "Aryan" ,"age":2},where: "id = ?", whereArgs: [id]);
    return res;
  }
}
