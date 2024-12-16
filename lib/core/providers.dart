import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:todo_app/features/todos/todos_viewmodel.dart';
import 'package:todo_app/features/todos_details/todos_details_viewmodel.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
    create: (context) => TodosViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => TodosDetailsViewModel(
      todosViewModel: context.read<TodosViewModel>(),
    ),
  ),
];
