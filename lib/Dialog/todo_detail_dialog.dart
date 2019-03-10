import 'package:flutter/material.dart';
import 'package:todo_app/Database/todo.dart';

typedef ChangeTodoCallback = void Function(Todo, String, String);
typedef DeleteTodoCallback = void Function(Todo);

class TodoDetailDialog extends StatelessWidget {

  TodoDetailDialog({@required this.todo, this.onChange, this.onDelete});

  final Todo todo;
  final ChangeTodoCallback onChange;
  final DeleteTodoCallback onDelete;

  TextEditingController titleController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    titleController.text = todo.title;
    detailController.text = todo.detail;
    var detailForm = new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          controller: titleController,
          decoration: InputDecoration(labelText: "Title"),
          autofocus: true,
        ),
        TextFormField(
          controller: detailController,
          decoration: InputDecoration(labelText: "Detail"),
          keyboardType: TextInputType.multiline,
        )
      ],
    );

    return AlertDialog(
      title: Text("Todo Detail"),
      content: detailForm,
      actions: <Widget>[
        FlatButton(
          child: Text("Delete"),
          onPressed: () {
            onDelete(todo);
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text("Save"),
          onPressed: () {
            onChange(todo, titleController.value.text, detailController.value.text);
            Navigator.of(context).pop();
          },
        )
      ]
    );
  }
}

