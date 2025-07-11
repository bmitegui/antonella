import 'package:antonella/core/error/error.dart';
import 'package:antonella/core/error/failures.dart';
import 'package:flutter/material.dart';
import 'package:antonella/core/l10n/app_localizations.dart';

String mapFailureToMessage(
    {required BuildContext context, required Failure failure}) {
  final texts = AppLocalizations.of(context)!;
  if (failure is ServerFailure) {
    return failure.message ?? texts.server_error;
  } else if (failure is CacheFailure) {
    return failure.message ?? texts.cache_error;
  } else if (failure is NetworkConnectionFailure) {
    return texts.network_connection_error;
  } else if (failure is IncorrectPasswordFailure) {
    return texts.password_error;
  } else if (failure is IncompleteFieldsFailure) {
    return texts.incomplete_fields;
  } else if (failure is InvalidUserEmailFailure) {
    return texts.invalid_user_email_error;
  } else if (failure is InvalidUserBirthdateFailure) {
    return texts.invalid_user_birthdate_error;
  } else if (failure is UserAlreadyExistsFailure) {
    return texts.user_already_exists_error;
  } else if (failure is InvalidUserNameFailure) {
    return texts.invalid_user_name_error;
  } else if (failure is InvalidDniFailure) {
    return texts.invalid_dni_error;
  } else if (failure is InvalidPhoneNumberFailure) {
    return texts.invalid_phone_number_error;
  } else if (failure is InvalidUserPasswordFailure) {
    return texts.invalid_user_password_error;
  } else {
    return texts.unexpected_error;
  }
}
