import 'package:todo_apps/data/models/todo.dart';
import 'package:todo_apps/data/network_service.dart';

class Repository {
  final NetworkService? networkService;
  Repository({
    this.networkService,
  });

  Future<List<Todo>> fetchTodos() async {
    final todoRaw = await networkService!.fetchTodos();
    return todoRaw.map((e) => Todo.formJson(e)).toList();
  }

  Future<bool> changeCompletion(bool isCompleted, String id) async {
    final patchObj = {"isCompleted": isCompleted.toString()};
    return await networkService!.patchTodo(patchObj, id);
  }

  Future<Todo?> addTodo(String message) async {
    final todoObj = {"todo": message, "isCompleted": "false"};

    final todoMap = await networkService!.addTodo(todoObj);
    if(todoMap == null) return null;

    return Todo.formJson(todoMap);
  }

  Future<bool> deleteTodo(String id) async{
    return await networkService!.deleteTodo(id);
  }
}
