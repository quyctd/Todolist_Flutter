import "package:flutter/material.dart";
import 'package:todo_app/todo.dart';
import 'package:todo_app/new_todo_dialog.dart';
import 'package:todo_app/todo_list.dart';
import 'package:todo_app/todo_detail_dialog.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {

  List<Todo> todos = [];

  _changeStateTodo(Todo todo, String title, String detail) {
    setState(() {
      todo.title = title;
      todo.detail = detail;
    });
  }

  _deleteTodo(Todo todo) {
    setState(() {
      todos.remove(todo);
    });
  }

  toggleTodo (Todo todo, bool isChecked) {
    setState(() {
      todo.isDone = isChecked;
    });
  }

  _toggleDetail (Todo todo) {

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return TodoDetailDialog(todo: todo, onChange: _changeStateTodo, onDelete: _deleteTodo,);
        }
    );
  }

  _addTodo() async {
    final todo = await showDialog<Todo>(
      context: context,
      builder: (BuildContext context) {
        return NewTodoDialog();
      }
    );

    if (todo != null) {
      setState(() {
        todos.add(todo);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo list")),
      body: TodoList(
          todos: todos,
          onTodoToggle: toggleTodo,
          onShowDetail: _toggleDetail,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addTodo,
      ),
    );
  }
}