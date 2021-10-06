import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_apps/constants/strings.dart';
import 'package:todo_apps/cubit/todos_cubit.dart';

class TodosScreen extends StatelessWidget {
  const TodosScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodosCubit>(context).fetchTodos();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos"),
        actions: [
          InkWell(
            onTap: () => Navigator.pushNamed(context, addTodoRoute),
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text("Todos Screen"),
      ),
    );
  }
}
