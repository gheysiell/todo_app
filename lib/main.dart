import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modules/todos/todos_view.dart';
import 'package:todo_app/utils/palette.dart';
import 'package:todo_app/utils/providers.dart';
import 'package:todo_app/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Todos',
        initialRoute: 'todos',
        routes: routes,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Palette.primary),
          useMaterial3: true,
        ),
        home: const TodoApp(),
      ),
    );
  }
}

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  Widget build(BuildContext context) {
    return const TodoView();
  }
}
