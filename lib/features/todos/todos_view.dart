import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/todos/todos_model.dart';
import 'package:todo_app/features/todos/todos_viewmodel.dart';
import 'package:todo_app/core/enums.dart';
import 'package:todo_app/shared/palette.dart';
import 'package:todo_app/shared/widgets/app_bar.dart';
import 'package:todo_app/shared/widgets/loader.dart';
import 'package:todo_app/shared/widgets/not_found.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => TodoViewState();
}

class TodoViewState extends State<TodoView> {
  late TodosViewModel _todosViewModel;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      _todosViewModel = context.watch<TodosViewModel>();

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await getTodosHandler();
      });

      _initialized = true;
    }
  }

  Future<void> getTodosHandler() async {
    await _todosViewModel.getTodos(context);
  }

  void navigateToDetailsHandler(TypeSave typeSave, Todo? todo) {
    _todosViewModel.navigateToDetails(context, typeSave, todo);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBarComponent(
            title: 'Lista de tarefas',
            leading: Image.asset(
              './assets/images/icon.png',
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
                    heightBody: (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        AppBar().preferredSize.height),
                    heightPaddingBottom: MediaQuery.of(context).padding.bottom,
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
