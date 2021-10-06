class Todo {
  late String todoMessage;
  late String isCompleted;
  late int id;

  Todo.formJson(Map json)
      : todoMessage = json["todo"],
        isCompleted = json["isCompleted"],
        id = json["id"] as int;
}
