import 'dart:async';
import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/features/todos/todos_model.dart';
import 'package:todo_app/features/todos/todos_result_model.dart';
import 'package:todo_app/core/constants.dart';
import 'package:todo_app/core/database.dart';
import 'package:todo_app/core/enums.dart';

class TodoRepository {
  Future<TodoResult> getTodos() async {
    TodoResult todoResult = TodoResult(
      todos: [],
      responseStatus: ResponseStatus.success,
    );

    try {
      Database db = await DatabaseApp().database;
      List<Map<String, dynamic>> results = await db
          .query(
            'todos',
            orderBy: 'id DESC',
          )
          .timeout(Constants.timeoutDuration);

      todoResult.todos = results.map((todo) => Todo.fromMap(todo)).toList();
    } on TimeoutException {
      log("timeout exception in TodoRepository.getTodos");
      todoResult.responseStatus = ResponseStatus.timeout;
    } catch (e) {
      log("generic exception in TodoRepository.getTodos", error: e);
      todoResult.responseStatus = ResponseStatus.error;
    }

    return todoResult;
  }

  Future<ResponseStatus> insertTodo(Todo todo) async {
    ResponseStatus responseStatus = ResponseStatus.success;

    try {
      Database db = await DatabaseApp().database;
      Map<String, dynamic> todoFormatted = todo.toMap(true);

      int resultInsert = await db
          .insert(
            'todos',
            todoFormatted,
          )
          .timeout(Constants.timeoutDuration);

      if (resultInsert == 0) throw Exception();
    } on TimeoutException {
      log("timeout exception in TodoRepository.insertTodo");
      responseStatus = ResponseStatus.timeout;
    } catch (e) {
      log("generic exception in TodoRepository.insertTodo", error: e);
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
      ).timeout(Constants.timeoutDuration);

      if (responseUpdate == 0) throw Exception();
    } on TimeoutException {
      log("timeout exception in TodoRepository.updateTodo");
      responseStatus = ResponseStatus.timeout;
    } catch (e) {
      log("generic exception in TodoRepository.updateTodo", error: e);
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
      ).timeout(Constants.timeoutDuration);

      if (resultDelete == 0) throw Exception();
    } on TimeoutException {
      log("timeout exception in TodoRepository.deleteTodo");
      responseStatus = ResponseStatus.timeout;
    } catch (e) {
      log("generic exception in TodoRepository.deleteTodo", error: e);
      responseStatus = ResponseStatus.error;
    }

    return responseStatus;
  }
}
