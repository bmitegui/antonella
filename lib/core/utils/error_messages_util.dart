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
  } else {
    return texts.unexpected_error;
  }
}
