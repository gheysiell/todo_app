import 'dart:async';
import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/modules/todos/todos_model.dart';
import 'package:todo_app/utils/database.dart';
import 'package:todo_app/utils/enums.dart';

class TodoRepository {
  Future<TodoResult> getTodos() async {
    TodoResult todoResult = TodoResult(
      responseStatus: ResponseStatus.success,
      todos: [],
    );

    try {
      Database db = await DatabaseApp().database;
      List<Map<String, dynamic>> results = await db.query(
        'todos',
        orderBy: 'id DESC',
      );

      for (var result in results) {
        todoResult.todos.add(
          Todo(
            id: result['id'],
            description: result['description'],
            completed: result['completed'] == 1,
          ),
        );
      }
    } catch (e) {
      log("Error when TodoRepository.getTodos", error: e);
      if (e is TimeoutException) {
        todoResult.responseStatus = ResponseStatus.timeout;
      } else {
        todoResult.responseStatus = ResponseStatus.error;
      }
    }

    return todoResult;
  }

  Future<ResponseStatus> insertTodo(Todo todo) async {
    ResponseStatus responseStatus = ResponseStatus.success;

    try {
      Database db = await DatabaseApp().database;
      Map<String, dynamic> todoFormatted = todo.toMap(true);

      int resultInsert = await db.insert(
        'todos',
        todoFormatted,
      );
      if (resultInsert == 0) throw Exception();
    } catch (e) {
      log('Error when TodoRepository.insertTodo', error: e);
      responseStatus = ResponseStatus.error;
    }

    return responseStatus;
  }

  Future<ResponseStatus> updateTodo(int id, Todo todo) async {
    ResponseStatus responseStatus = ResponseStatus.success;

    try {
      Database db = await DatabaseApp().database;
      Map<String, dynamic> todoFormatted = todo.toMap(true);
      todoFormatted.remove('id');

      int responseUpdate = await db.update(
        'todos',
        todoFormatted,
        where: 'id = ?',
        whereArgs: [id],
      );

      if (responseUpdate == 0) throw Exception();
    } catch (e) {
      log('Error when TodoRepository.updateTodo', error: e);
      responseStatus = ResponseStatus.error;
    }

    return responseStatus;
  }

  Future<ResponseStatus> deleteTodo(int id) async {
    ResponseStatus responseStatus = ResponseStatus.success;

    try {
      Database db = await DatabaseApp().database;
      int resultDelete = await db.delete(
        'todos',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (resultDelete == 0) throw Exception();
    } catch (e) {
      log('Error when TodoRepository.deleteTodo', error: e);
      responseStatus = ResponseStatus.error;
    }

    return responseStatus;
  }
}
