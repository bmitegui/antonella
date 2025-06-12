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
    ? 'yyyy-MM-dd'
    : DateFormat('yyyy-MM-dd').format(dateTime.toLocal());

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

Future<DateTime?> selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100));
  return picked;
}

void navigateWithSlideTransition(BuildContext context, Widget page) {
  Navigator.push(
      context,
      PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
          }));
}
