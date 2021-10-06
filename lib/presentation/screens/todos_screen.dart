import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_apps/constants/strings.dart';
import 'package:todo_apps/cubit/todos_cubit.dart';
import 'package:todo_apps/data/models/todo.dart';

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
      body: BlocBuilder<TodosCubit, TodosState>(
        builder: (context, state) {
          if (state is! TodosLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          final todos = (state is TodosLoaded) ? state.todos : null;

          return SingleChildScrollView(
            child: Column(
              children: todos!.map((e) => _todos(e, context)).toList(),
            ),
          );
        },
      ),
    );
  }

  Widget _todos(Todo todo, BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, editTodoRoute),
      child: Dismissible(
        key: Key(todo.id),
        child: _todoTile(context, todo),
        confirmDismiss: (_) async{
          context.read<TodosCubit>().changeCompletion(todo);
          return false;
        },
        background: Container(
          color: Colors.indigo,
        ),
      ),
    );
  }

  Widget _todoTile(BuildContext context, Todo todo) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(todo.todoMessage),
          _completionIndicator(todo),
        ],
      ),
    );
  }

  Widget _completionIndicator(Todo todo) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          width: 4,
          color: todo.isCompleted ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
