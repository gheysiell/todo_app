import 'package:form_validator/form_validator.dart';

class Validators {
  static final required = ValidationBuilder(
    requiredMessage: 'Campo obrigatório',
    localeName: 'pt-br',
  ).minLength(1, 'Campo obrigatório').build();
}
