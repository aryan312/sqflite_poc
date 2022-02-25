import 'package:flutter/material.dart';
import 'package:sqflite_poc/database/databaseHelper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final dbhelper =DatabaseHelper.instance;
  void insertdata() async{
    Map<String, dynamic> row ={
      DatabaseHelper.columnName:'Prince',
      DatabaseHelper.columnage:20
    };
    final id= await dbhelper.insert(row);
    print(id);
  }
  void queryAll() async{
   var allrows= await dbhelper.queryAll();
   allrows.forEach((row) {
     print(row);
   });
  }
  void querySpecific() async{
    var allrows= await dbhelper.querySpecific(18);
   print(allrows);
  }
  void deleteData() async{
    int id  = await dbhelper.deleteData(2);
    print(id);
  }
  void updateData() async{
    var row  = await dbhelper.update(1);
    print(row);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RaisedButton(
                padding: EdgeInsets.all(10),
                child: Text('INSERT'),
                onPressed: (){
                  insertdata();
                },
              ),
              RaisedButton(
                padding: EdgeInsets.all(10),
                child: Text('QUERY'),
                onPressed: (){
                  queryAll();
                },
              ),
              RaisedButton(
                padding: EdgeInsets.all(10),
                child: Text('QUERY SPECIFIC'),
                onPressed: (){
                  querySpecific();
                },
              ),
              RaisedButton(
                padding: EdgeInsets.all(10),
                child: Text('UPDATE'),
                onPressed: (){
                  updateData();
                },
              ),
              RaisedButton(
                padding: EdgeInsets.all(10),
                child: Text('DELETE'),
                onPressed: (){
                  deleteData();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
