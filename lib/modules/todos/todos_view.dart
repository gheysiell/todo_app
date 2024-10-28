import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modules/todos/todos_model.dart';
import 'package:todo_app/modules/todos/todos_view_model.dart';
import 'package:todo_app/utils/enums.dart';
import 'package:todo_app/utils/palette.dart';
import 'package:todo_app/widgets/app_bar.dart';
import 'package:todo_app/widgets/loader.dart';
import 'package:todo_app/widgets/not_found.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => TodoViewState();
}

class TodoViewState extends State<TodoView> {
  late TodosViewModel _todosViewModel;
  late double heightPaddingBottom;
  late double heightBody;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      _todosViewModel = Provider.of<TodosViewModel>(context);
      heightPaddingBottom = MediaQuery.of(context).padding.bottom;
      heightBody =
          (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - AppBar().preferredSize.height);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _todosViewModel.getTodos(context);
      });

      _initialized = true;
    }
  }

  void navigateToDetailsHandler(TypeSave typeSave, Todo? todo) {
    _todosViewModel.navigateToDetails(context, typeSave, todo);
  }

  Future<void> getTodosHandler() async {
    await _todosViewModel.getTodos(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBarComponent(
            title: 'Lista de tarefas',
            leading: Container(
              margin: const EdgeInsets.only(left: 12),
              child: Image.asset(
                './assets/images/app_icon.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          body: RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.onEdge,
            color: Palette.primary,
            onRefresh: () async {
              await getTodosHandler();
            },
            child: _todosViewModel.todos.isEmpty
                ? NotFoundComponent(
                    padding: 10,
                    contextArg: context,
                    title: 'Tarefas não encontradas',
                    heightBody: heightBody,
                    heightPaddingBottom: heightPaddingBottom,
                  )
                : ListView.builder(
                    itemCount: _todosViewModel.todos.length,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (BuildContext context, int index) {
                      return TextButton(
                        onPressed: () {
                          navigateToDetailsHandler(TypeSave.update, _todosViewModel.todos[index]);
                        },
                        style: TextButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                color: _todosViewModel.getColorOfTodo(_todosViewModel.todos[index].completed),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              _todosViewModel.todos[index].description,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Palette.silverBold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          floatingActionButton: Tooltip(
            message: 'Criar nova tarefa',
            child: FloatingActionButton(
              onPressed: () async {
                navigateToDetailsHandler(TypeSave.insert, null);
              },
              backgroundColor: Palette.primary,
              child: const Icon(
                Icons.add_rounded,
                color: Palette.white,
                size: 36,
              ),
            ),
          ),
        ),
        LoaderComponent(loaderVisible: _todosViewModel.loaderVisible)
      ],
    );
  }
}
