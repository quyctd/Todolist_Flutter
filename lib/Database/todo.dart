class Todo {
  Todo({this.id, this.title, this.isDone = 0, this.detail = ""});

  int id;
  String title;
  int isDone;
  String detail;

  factory Todo.fromJson(Map<String, dynamic> json) => new Todo(
    id: json["id"],
    title: json["title"],
    detail: json["detail"],
    isDone: json["isDone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "detail": detail,
    "isDone": isDone,
  };
}