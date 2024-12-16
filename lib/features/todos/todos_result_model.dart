import 'package:todo_app/features/todos/todos_model.dart';
import 'package:todo_app/core/enums.dart';

class TodoResult {
  List<Todo> todos;
  ResponseStatus responseStatus;

  TodoResult({
    required this.todos,
    required this.responseStatus,
  });
}
