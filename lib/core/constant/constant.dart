import 'package:antonella/features/service/domain/entities/service_entity.dart';
import 'package:flutter/material.dart';

const String networkConnectionError = 'No hay conexión a internet';
const unexpectedError = 'Error inesperado';
const userNotAuthenticatedError = 'No se encuentra autenticado';
const appName = 'Antonella';

const supportedLocales = [Locale('en'), Locale('es')];

final imagesServiceCategory = {
  ServiceCategory.all: 'assets/img/all.jpg',
  ServiceCategory.makeup: 'assets/img/makeup.jpg',
  ServiceCategory.spa: 'assets/img/spa.jpg',
  ServiceCategory.nails: 'assets/img/nails.jpg',
  ServiceCategory.hair: 'assets/img/hair.jpg',
};