import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_apps/cubit/add_todo_cubit.dart';

class AddTodoScreen extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  AddTodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Todo"),
        ),
        body: BlocListener<AddTodoCubit, AddTodoState>(
          listener: (context, state) {
            if (state is TodoAdded) {
              Navigator.pop(context);
              return;
            }
          },
          child: Container(
            margin: const EdgeInsets.all(20),
            child: _body(context),
          ),
        ));
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        TextField(
          autofocus: true,
          controller: controller,
          decoration: const InputDecoration(hintText: "Enter todo message"),
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            final message = controller.text;
            BlocProvider.of<AddTodoCubit>(context).addTodo(message);
          },
          child: _addBtn(context),
        ),
      ],
    );
  }

  Widget _addBtn(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: BlocBuilder<AddTodoCubit, AddTodoState>(
          builder: (context, state) {
            if (state is AddingTodo) {
              return const CircularProgressIndicator();
            }

            return const Text(
              "Add Todo",
              style: TextStyle(color: Colors.white),
            );
          },
        ),
      ),
    );
  }
}
