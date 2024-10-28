import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:todo_app/modules/todos/todos_view_model.dart';
import 'package:todo_app/modules/todos_details/todos_details_view_model.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => TodosViewModel()),
  ChangeNotifierProvider(create: (_) => TodosDetailsViewModel()),
];
