import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_apps/cubit/edit_todo_cubit.dart';

import 'package:todo_apps/data/models/todo.dart';

class EditTodoScreen extends StatelessWidget {
  final Todo todo;

  EditTodoScreen({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.text = todo.todoMessage;
    return BlocListener<EditTodoCubit, EditTodoState>(
      listener: (context, state) {
        if (state is TodoEdited) {
          Navigator.pop(context);
        } else if (state is EditTodoError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("EDIT TODO"),
            actions: [
              IconButton(
                padding: const EdgeInsets.all(10),
                onPressed: () {
                  BlocProvider.of<EditTodoCubit>(context).deleteTodo(todo);
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          body: _body(context)),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextField(
            controller: controller,
            autocorrect: true,
            decoration: const InputDecoration(hintText: "Enter Todo Message"),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              BlocProvider.of<EditTodoCubit>(context).updateTodo(todo);
            },
            child: _updateBtn(context),
          ),
        ],
      ),
    );
  }

  Widget _updateBtn(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: Text(
          "Update Todo",
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
    );
  }
}
