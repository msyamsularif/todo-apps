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
}
