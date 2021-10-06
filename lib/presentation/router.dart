import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_apps/constants/strings.dart';
import 'package:todo_apps/cubit/todos_cubit.dart';
import 'package:todo_apps/data/network_service.dart';
import 'package:todo_apps/data/repository.dart';
import 'package:todo_apps/presentation/screens/add_todo_screen.dart';
import 'package:todo_apps/presentation/screens/edit_todo_screen.dart';
import 'package:todo_apps/presentation/screens/todos_screen.dart';

class AppRouter {
  Repository? repository;

  AppRouter() {
    repository = Repository(
      networkService: NetworkService(),
    );
  }
  Route? generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => TodosCubit(repository: repository!),
            child: const TodosScreen(),
          ),
        );
      case editTodoRoute:
        return MaterialPageRoute(
          builder: (_) => const EditTodoScreen(),
        );
      case addTodoRoute:
        return MaterialPageRoute(
          builder: (_) => const AddTodoScreen(),
        );
      default:
        return null;
    }
  }
}
