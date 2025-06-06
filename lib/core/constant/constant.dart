import 'package:antonella/features/service/domain/entities/service_entity.dart';
import 'package:flutter/material.dart';

const String networkConnectionError = 'No hay conexión a internet';
const unexpectedError = 'Error inesperado';
const userNotAuthenticatedError = 'No se encuentra autenticado';
const appName = 'Antonella';

const supportedLocales = [Locale('en'), Locale('es')];

final imagesServiceCategory = {
  ServiceCategory.all: 'assets/svg/all.svg',
  ServiceCategory.makeup: 'assets/svg/makeup.svg',
  ServiceCategory.spa: 'assets/svg/spa.svg',
  ServiceCategory.nails: 'assets/svg/nails.svg',
  ServiceCategory.hair: 'assets/svg/hair.svg',
};