import 'package:antonella/features/service/domain/entities/service_entity.dart';
import 'package:flutter/material.dart';

const String networkConnectionError = 'No hay conexión a internet';
const unexpectedError = 'Error inesperado';
const userNotAuthenticatedError = 'No se encuentra autenticado';
const appName = 'Antonella';

const supportedLocales = [Locale('en'), Locale('es')];

final imagesServiceCategory = {
  ServiceType.all: 'assets/svg/all.svg',
  ServiceType.makeup: 'assets/svg/makeup.svg',
  ServiceType.spa: 'assets/svg/spa.svg',
  ServiceType.nails: 'assets/svg/nails.svg',
  ServiceType.hair: 'assets/svg/hair.svg',
};

//Support Contact
const String phoneNumber = '+593 961530738';
const String email = 'contacto@hubitrack.com';
const String instagram = 'https://www.instagram.com/antonellacbe/';
