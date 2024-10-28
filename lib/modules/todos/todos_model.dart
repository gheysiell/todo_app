import 'package:todo_app/utils/enums.dart';

class Todo {
  final int id;
  final String description;
  final bool completed;

  Todo({
    required this.id,
    required this.description,
    required this.completed,
  });

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as int,
      description: map['description'] as String,
      completed: map['completed'] as bool,
    );
  }

  Map<String, dynamic> toMap(bool toDB) {
    return {
      'id': toDB ? null : id,
      'description': description,
      'completed': toDB ? (completed ? 1 : 0) : completed,
    };
  }

  static Todo getDefault() {
    return Todo(
      id: 0,
      description: '',
      completed: false,
    );
  }
}

class TodoResult {
  ResponseStatus responseStatus;
  List<Todo> todos;

  TodoResult({
    required this.responseStatus,
    required this.todos,
  });
}
