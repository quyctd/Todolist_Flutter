import 'package:flutter/material.dart';
import 'package:todo_app/Database/todo.dart';

class NewTodoDialog extends StatelessWidget {
  final titleController = new TextEditingController();
  final detailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    String title;
    String detail = "";

    var newTodoForm = Column(
      children: <Widget>[
        TextField(
          controller: titleController,
          decoration: InputDecoration(labelText: "Title"),
          autofocus: true,
        ),
        TextField(
          controller: detailController,
          decoration: InputDecoration(labelText: "Detail"),
          keyboardType: TextInputType.multiline,
        )
      ],
    );

    return AlertDialog(
        title: Text("New todo"),
        content: newTodoForm,
        actions: <Widget>[
          FlatButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text("Add"),
            onPressed: () {
              final todo = new Todo(title: titleController.value.text, detail : detailController.value.text);
              titleController.clear();
              detailController.clear();
              Navigator.of(context).pop(todo);
            },
          )
        ]
    );
  }
}