import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/todos/todos_result_model.dart';
import 'package:todo_app/features/todos_details/todos_details_view.dart';
import 'package:todo_app/features/todos_details/todos_details_viewmodel.dart';
import 'package:todo_app/features/todos/todos_model.dart';
import 'package:todo_app/features/todos/todos_repository.dart';
import 'package:todo_app/core/enums.dart';
import 'package:todo_app/shared/functions.dart';
import 'package:todo_app/shared/palette.dart';

class TodosViewModel extends ChangeNotifier {
  TodoRepository todoRepository = TodoRepository();
  List<Todo> todos = [];
  bool loaderVisible = false;

  void setLoaderVisible(bool value) {
    loaderVisible = value;
    notifyListeners();
  }

  void setTodos(List<Todo> value) {
    todos = value;
    notifyListeners();
  }

  Future<void> getTodos(BuildContext context) async {
    setLoaderVisible(true);

    TodoResult response = await todoRepository.getTodos();

    setLoaderVisible(false);

    String messageError = '';

    setTodos(response.todos);

    if (response.responseStatus == ResponseStatus.error) {
      messageError = "Erro ao buscar as tarefas, tente novamente.";
    } else if (response.responseStatus == ResponseStatus.timeout) {
      messageError = "Tempo de consulta excedido, tente novamente.";
    }

    if (messageError.isNotEmpty && context.mounted) {
      Functions.showGeneralAlertDialog(
        context,
        messageError,
        TypeMessageDialog.error,
      );
    }
  }

  Future<ResponseStatus> insertTodo(Todo todo) async {
    return await todoRepository.insertTodo(todo);
  }

  Future<ResponseStatus> updateTodo(int id, Todo todo) async {
    return await todoRepository.updateTodo(id, todo);
  }

  Future<ResponseStatus> deleteTodo(int id) async {
    return await todoRepository.deleteTodo(id);
  }

  void navigateToDetails(
    BuildContext context,
    TypeSave typeSave,
    Todo? todo,
  ) {
    TodosDetailsViewModel todosDetailsViewModel = Provider.of<TodosDetailsViewModel>(context, listen: false);
    todosDetailsViewModel.setInitialValues(typeSave, typeSave == TypeSave.insert ? null : todo);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TodosDetailsView(
          typeSave: typeSave,
        ),
      ),
    );
  }

  Color getColorOfTodo(bool active) => active ? Palette.blue : Palette.mediumRed;
}
