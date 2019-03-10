import 'package:flutter/material.dart';
import 'package:todo_app/Database/todo.dart';

typedef ToggleTodoCallback = void Function(Todo, bool);
typedef TodoDetailCallback = void Function(Todo);

class TodoList extends StatelessWidget {
  TodoList({@required this.todos, this.onTodoToggle, this.onShowDetail});

  final List<Todo> todos;
  final ToggleTodoCallback onTodoToggle;
  final TodoDetailCallback onShowDetail;

  Widget _buildItem(BuildContext context, int index) {
    final todo = todos[index];

    return Row(
      children: <Widget>[
        Expanded(
            child: FlatButton(
          padding: EdgeInsets.all(20),
          child: SizedBox(
            width: double.infinity,
            child: Text(todo.title,
                textAlign : TextAlign.left,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          onPressed: () => onShowDetail(todo),
        )),
        Checkbox(
          value: (todo.isDone == 0 ? false : true),
          onChanged: (bool isChecked) {
            onTodoToggle(todo, isChecked);
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildItem,
      itemCount: todos.length,
    );
  }
}
