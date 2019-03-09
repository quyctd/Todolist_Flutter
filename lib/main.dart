import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/todolist_screen.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Todo List",
      home: TodoListScreen()
    );
  }
}
