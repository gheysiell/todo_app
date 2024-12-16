import 'package:flutter/material.dart';
import 'package:todo_app/features/todos/todos_view.dart';
import 'package:todo_app/features/todos_details/todos_details_view.dart';

Map<String, Widget Function(BuildContext)> routes = {
  'todos': (context) => const TodoView(),
  'todos_details': (context) => const TodosDetailsView(),
};
