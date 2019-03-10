import 'package:sqflite/sqflite.dart';
import "package:todo_app/Database/todo.dart";
import 'dart:async';

final String todoTable = "TodoItems";


class DataAccess {
  static final DataAccess _instance = DataAccess._internal();
  Database _db;

  factory DataAccess() {
    return _instance;
  }

  DataAccess._internal();

  Future open() async {
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + "\todo.db";

    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
            create table $todoTable ( 
            id integer primary key autoincrement, 
            title text not null,
            detail text,
            isDone integer)
            ''');
        });

    // This is just a convenience block to populate the database if it's empty.
    // We likely wouldn't use this in a real application
    if((await getTodoItems()).length == 0) {
      insertTodo(Todo(title: "task 1", detail:"Task 1 go here"));
      insertTodo(Todo(title: "task 2", detail:"Task 2 go here"));
      insertTodo(Todo(title: "task 3", detail:"Task 3 go here"));
    }
  }

  Future<List<Todo>> getTodoItems() async {
    var data = await _db.query(todoTable);
    return data.map((d) => Todo.fromJson(d)).toList();
  }

  Future insertTodo(Todo item) {
    return _db.insert(todoTable, item.toJson());
  }

  Future updateTodo(Todo item) {
    return _db.update(todoTable, item.toJson(),
        where: "id = ?", whereArgs: [item.id]);
  }

  Future deleteTodo(Todo item) {
    return _db.delete(todoTable, where: "id = ?", whereArgs: [item.id]);
  }
}