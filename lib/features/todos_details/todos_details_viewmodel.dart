import 'package:flutter/material.dart';
import 'package:todo_app/features/todos/todos_model.dart';
import 'package:todo_app/features/todos/todos_viewmodel.dart';
import 'package:todo_app/core/enums.dart';
import 'package:todo_app/shared/functions.dart';
import 'package:todo_app/shared/validators.dart';

class TodosDetailsViewModel extends ChangeNotifier {
  late Todo todo;
  TodosViewModel todosViewModel;
  TextEditingController textEditingControllerDescription = TextEditingController();
  FocusNode focusNodeDescription = FocusNode();
  bool completed = false;
  bool showDescriptionFieldRequired = false;
  bool loaderVisible = false;

  TodosDetailsViewModel({
    required this.todosViewModel,
  });

  void setTodo(Todo value) {
    todo = value;
    notifyListeners();
  }

  void setFocusNodeDescription(FocusNode value) {
    focusNodeDescription = value;
    notifyListeners();
  }

  void setLoaderVisible(bool value) {
    loaderVisible = value;
    notifyListeners();
  }

  void setCompleted(bool value) {
    completed = value;
    notifyListeners();
  }

  void setShowDescriptionFieldRequired(bool value) {
    showDescriptionFieldRequired = value;
    notifyListeners();
  }

  void navigateBack(BuildContext context) {
    Navigator.pop(context);
  }

  void setInitialValues(
    TypeSave typeSave,
    Todo? todoArg,
  ) {
    if (typeSave == TypeSave.insert) {
      textEditingControllerDescription.text = '';
      setShowDescriptionFieldRequired(false);
      setCompleted(false);
      setTodo(Todo.getDefault());
    } else {
      textEditingControllerDescription.text = todoArg!.description;
      setCompleted(todoArg.completed);
      setTodo(todoArg);
    }
  }

  Future<void> saveTodoCaller(
    BuildContext context,
    TypeSave typeSave,
    GlobalKey<FormState> formKey,
  ) async {
    if (!validateTextsFormFields(formKey)) {
      Functions.vibrate();
      return;
    }

    TypeMessageDialog typeMessageDialog;
    ResponseStatus responseStatus;
    String operationNameSuccess;
    String operationName;
    String messageDialog;

    Todo todoEntry = Todo(
      id: todo.id,
      description: textEditingControllerDescription.text,
      completed: completed,
    );

    setLoaderVisible(true);

    if (typeSave == TypeSave.insert) {
      responseStatus = await todosViewModel.insertTodo(todoEntry);
      operationNameSuccess = 'criada';
      operationName = 'criar';
    } else {
      responseStatus = await todosViewModel.updateTodo(todo.id, todoEntry);
      operationNameSuccess = 'alterada';
      operationName = 'alterar';
    }

    setLoaderVisible(false);

    if (responseStatus == ResponseStatus.success) {
      typeMessageDialog = TypeMessageDialog.info;
      messageDialog = 'Tarefa $operationNameSuccess com sucesso.';
    } else if (responseStatus == ResponseStatus.error) {
      typeMessageDialog = TypeMessageDialog.error;
      messageDialog = 'Erro ao $operationName a tarefa, tente novamente.';
    } else {
      typeMessageDialog = TypeMessageDialog.error;
      messageDialog = 'Tempo de consulta excedido, tente novamente.';
    }

    if (context.mounted) await Functions.showGeneralAlertDialog(context, messageDialog, typeMessageDialog);

    if (responseStatus != ResponseStatus.success) return;

    if (context.mounted) navigateBack(context);
    if (context.mounted) todosViewModel.getTodos(context);
  }

  Future<void> deleteTodoCaller(BuildContext context) async {
    TypeMessageDialog typeMessageDialog;
    ResponseStatus responseStatus;
    String messageDialog;
    double width = MediaQuery.of(context).size.width;

    if (!await Functions.dialogConfirmationDanger(
      context,
      'Deseja realmente excluir essa tarefa ?',
      55,
      width,
    )) return;

    setLoaderVisible(true);

    responseStatus = await todosViewModel.deleteTodo(todo.id);

    setLoaderVisible(false);

    if (responseStatus == ResponseStatus.success) {
      typeMessageDialog = TypeMessageDialog.info;
      messageDialog = 'Tarefa excluída com sucesso.';
    } else if (responseStatus == ResponseStatus.error) {
      typeMessageDialog = TypeMessageDialog.error;
      messageDialog = 'Erro ao excluir a tarefa, tente novamente.';
    } else {
      typeMessageDialog = TypeMessageDialog.error;
      messageDialog = 'Tempo de consulta excedido, tente novamente.';
    }

    if (context.mounted) await Functions.showGeneralAlertDialog(context, messageDialog, typeMessageDialog);

    if (responseStatus != ResponseStatus.success) return;

    if (context.mounted) navigateBack(context);
    if (context.mounted) todosViewModel.getTodos(context);
  }

  bool validationFieldsCondition(int setOrRemove) {
    String text = textEditingControllerDescription.text;
    return (setOrRemove == 0 ? Validators.required(text) != null : Validators.required(text) == null) &&
        showDescriptionFieldRequired;
  }

  bool validateTextsFormFields(GlobalKey<FormState> formKey) {
    bool validated = true;
    String textDescription = textEditingControllerDescription.text;

    if (Validators.required(textDescription) != null) {
      setShowDescriptionFieldRequired(true);
      validated = false;
    }

    if (Validators.required(textDescription) == null) {
      setShowDescriptionFieldRequired(false);
    }

    formKey.currentState!.validate();
    return validated;
  }
}
