import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modules/todos_details/todos_details_view_model.dart';
import 'package:todo_app/utils/enums.dart';
import 'package:todo_app/utils/palette.dart';
import 'package:todo_app/utils/styles.dart';
import 'package:todo_app/widgets/app_bar.dart';
import 'package:todo_app/widgets/loader.dart';

class TodosDetailsView extends StatefulWidget {
  final TypeSave? typeSave;

  const TodosDetailsView({
    super.key,
    this.typeSave,
  });

  @override
  State<TodosDetailsView> createState() => TodosDetailsViewState();
}

class TodosDetailsViewState extends State<TodosDetailsView> {
  late TodosDetailsViewModel _todosDetailsViewModel;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      _todosDetailsViewModel = Provider.of<TodosDetailsViewModel>(context);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (widget.typeSave == TypeSave.insert) {
          _todosDetailsViewModel.focusNodeDescription.requestFocus();
          _todosDetailsViewModel.setFocusNodeDescription(_todosDetailsViewModel.focusNodeDescription);
        }
      });

      _initialized = true;
    }
  }

  void navigateBackHandler() {
    _todosDetailsViewModel.navigateBack(context);
  }

  bool validationFieldsConditionHandler(int setOrRemove) {
    return _todosDetailsViewModel.validationFieldsCondition(
      setOrRemove,
    );
  }

  Future<void> saveTodoCallerHandler() async {
    await _todosDetailsViewModel.saveTodoCaller(context, widget.typeSave!, _formKey);
  }

  Future<void> deleteTodoCallerHandler() async {
    await _todosDetailsViewModel.deleteTodoCaller(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: AppBarComponent(
              title: 'Tarefa',
              leading: IconButton(
                tooltip: 'Voltar',
                onPressed: () {
                  navigateBackHandler();
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  size: 30,
                  color: Palette.white,
                ),
              ),
              actions: [
                if (widget.typeSave! == TypeSave.update)
                  IconButton(
                    tooltip: 'Excluir',
                    onPressed: () {
                      deleteTodoCallerHandler();
                    },
                    icon: const Icon(
                      Icons.delete,
                      size: 30,
                      color: Palette.white,
                    ),
                  ),
                IconButton(
                  tooltip: 'Salvar',
                  onPressed: () {
                    saveTodoCallerHandler();
                  },
                  icon: const Icon(
                    Icons.check,
                    size: 30,
                    color: Palette.white,
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        return ValidationBuilder(
                          requiredMessage: 'Campo obrigatório',
                          localeName: 'pt-br',
                        ).minLength(1, 'Campo obrigatório').build()(value);
                      },
                      controller: _todosDetailsViewModel.textEditingControllerDescription,
                      focusNode: _todosDetailsViewModel.focusNodeDescription,
                      style: TextFormFieldStyles.textStyle(),
                      decoration: InputDecoration(
                        labelText: 'Descrição',
                        labelStyle: TextStyle(
                          fontSize: 16,
                          color: validationFieldsConditionHandler(0) ? Palette.mediumRed : Palette.silver,
                        ),
                        floatingLabelStyle: TextStyle(
                          color: _todosDetailsViewModel.focusNodeDescription.hasFocus
                              ? validationFieldsConditionHandler(0)
                                  ? null
                                  : Palette.primary
                              : validationFieldsConditionHandler(0)
                                  ? null
                                  : Palette.silver,
                          fontSize: 19,
                        ),
                        fillColor: Palette.grey100,
                        isDense: true,
                        filled: true,
                        enabledBorder: TextFormFieldStyles.enabledBorder,
                        focusedBorder: TextFormFieldStyles.focusedBorder,
                        border: const OutlineInputBorder(),
                        errorStyle: TextFormFieldStyles.errorStyle(),
                        errorBorder: TextFormFieldStyles.errorBorder(),
                        focusedErrorBorder: TextFormFieldStyles.focusedErrorBorder(),
                        counterText: '',
                      ),
                      onTap: (() {
                        _todosDetailsViewModel.focusNodeDescription.requestFocus();
                        _todosDetailsViewModel.setFocusNodeDescription(_todosDetailsViewModel.focusNodeDescription);
                      }),
                      onChanged: (value) {
                        if (validationFieldsConditionHandler(1)) {
                          _formKey.currentState!.validate();
                          _todosDetailsViewModel.setShowDescriptionFieldRequired(false);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Concluída',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                            color: Palette.silverBold,
                          ),
                        ),
                        Switch(
                          value: _todosDetailsViewModel.completed,
                          activeTrackColor: Palette.blue,
                          inactiveTrackColor: null,
                          onChanged: (value) {
                            _todosDetailsViewModel.setCompleted(value);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        LoaderComponent(loaderVisible: _todosDetailsViewModel.loaderVisible)
      ],
    );
  }
}
