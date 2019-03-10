import "package:flutter/material.dart";
import 'package:todo_app/Database/todo.dart';
import 'package:todo_app/Dialog/new_todo_dialog.dart';
import 'package:todo_app/todo_list.dart';
import 'package:todo_app/Dialog/todo_detail_dialog.dart';
import 'package:todo_app/Database/DbAccess.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {

  List<Todo> todos = [];
  DataAccess _dataAccess;

  _TodoListScreenState() {
    _dataAccess = new DataAccess();
  }

  @override
  initState() {
    super.initState();
    _dataAccess.open().then((result) {
      _dataAccess.getTodoItems().then((r) {
        setState(() { todos = r; });
      });
    });
  }

  _setStateTodoItems() {
    _dataAccess.getTodoItems().then((items) {
      setState(() { todos = items; });
    });
  }

  _editTodo(Todo todo, String title, String detail) {
    todo.title = title;
    todo.detail = detail;
    _dataAccess.updateTodo(todo);
    _setStateTodoItems();
  }

  _deleteTodo(Todo todo) {
    _dataAccess.deleteTodo(todo);
    _setStateTodoItems();
  }

  toggleTodoCompleteStatus (Todo todo, bool isChecked) {
    todo.isDone = isChecked ? 1 : 0;
    _dataAccess.updateTodo(todo);
    _setStateTodoItems();

  }

  _toggleDetail (Todo todo) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return TodoDetailDialog(todo: todo, onChange: _editTodo, onDelete: _deleteTodo,);
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
      _dataAccess.insertTodo(todo);
      _setStateTodoItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo list")),
      body: TodoList(
          todos: todos,
          onTodoToggle: toggleTodoCompleteStatus,
          onShowDetail: _toggleDetail,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addTodo,
      ),
    );
  }
}