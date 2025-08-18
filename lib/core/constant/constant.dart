import 'package:antonella/features/service/domain/entities/service_entity.dart';
import 'package:flutter/material.dart';

const String networkConnectionError = 'No hay conexión a internet';
const unexpectedError = 'Error inesperado';
const userNotAuthenticatedError = 'No se encuentra autenticado';
const appName = 'Antonella';

const supportedLocales = [Locale('en'), Locale('es')];

final imagesServiceCategory = {
  ServiceType.all: 'assets/img/all.png',
  ServiceType.makeup: 'assets/img/makeup.png',
  ServiceType.spa: 'assets/img/spa.png',
  ServiceType.nails: 'assets/img/nails.png',
  ServiceType.hair: 'assets/img/hair.png',
};

//Support Contact
const String phoneNumber = '+593 961530738';
const String email = 'hangaroadeveloper@gmail.com';
const String instagram = 'https://www.instagram.com/antonellacbe/';
const String privacyPolicies = 'https://www.termsfeed.com/live/8722ba1c-6282-4305-b94b-74c5c0dba27b';
