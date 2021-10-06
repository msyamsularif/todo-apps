class Todo {
  late String todoMessage;
  late bool isCompleted;
  late String id;

  Todo.formJson(Map json)
      : todoMessage = json["todo"],
        isCompleted = json["isCompleted"] == "true",
        id = json["id"];
}
