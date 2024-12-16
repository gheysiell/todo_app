import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/shared/palette.dart';
import 'package:todo_app/core/providers.dart';
import 'package:todo_app/core/routes.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Lista de tarefas',
        initialRoute: 'todos',
        routes: routes,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Nunito',
          colorScheme: ColorScheme.fromSeed(seedColor: Palette.primary),
          useMaterial3: true,
        ),
      ),
    );
  }
}
