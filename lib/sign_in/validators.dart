import 'package:get/get.dart';

abstract class StringValidator {
  bool isValid(String value);
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.isNotEmpty;
  }
}

class EmailAndPasswordValidators {
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator passwordValidator = NonEmptyStringValidator();
  final StringValidator nameValidator = NonEmptyStringValidator();
  final StringValidator surnameValidator = NonEmptyStringValidator();

  final String inValidEmailErrorText = "email_cant_be_empty".tr;
  final String inValidPasswordErrorText = "password_cant_be_empty".tr;
  final String inValidNameErrorText = "name_cant_be_empty".tr;
  final String inValidSurnameErrorText = "surname_cant_be_empty".tr;
  final String signInFailedText = 'error_on_signing'.tr;
}
