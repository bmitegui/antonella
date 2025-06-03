import 'dart:io';
import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/features/service/domain/entities/service_entity.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

String formatDateToString(DateTime date) {
  return "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
}

DateTime parseStringToDate(String dateString) {
  return DateTime.parse(dateString);
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor ingresa tu correo o teléfono';
  }
  final emailRegExp =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
  if (!emailRegExp.hasMatch(value)) {
    return 'Por favor ingresa un correo válido';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor ingresa tu contraseña';
  }
  return null;
}

String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor ingresa tu nombre';
  }
  return null;
}

String? validateBirthdate(String? value) {
  if (value == null || value.isEmpty) {
    return 'Fecha faltante';
  }
  return null;
}

Future<File?> pickImage(ImageSource imageSource) async {
  final pickedImage =
      await ImagePicker().pickImage(source: imageSource, imageQuality: 50);
  if (pickedImage == null) {
    return null;
  }
  return File(pickedImage.path);
}

String formatDateTime(DateTime? dateTime) => dateTime == null
    ? 'dd-MM-yyyy'
    : DateFormat('dd-MM-yyyy').format(dateTime.toLocal());

String capitalize(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1).toLowerCase();
}

String getCategoryText(
    {required BuildContext context, required ServiceCategory serviceCategory}) {
  final texts = AppLocalizations.of(context)!;
  return (serviceCategory == ServiceCategory.hair)
      ? texts.hair
      : (serviceCategory == ServiceCategory.nails)
          ? texts.nails
          : (serviceCategory == ServiceCategory.spa)
              ? texts.spa
              : (serviceCategory == ServiceCategory.makeup)
                  ? texts.makeup
                  : texts.all;
}
