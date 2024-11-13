String formatDateToString(DateTime date) {
  return "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
}

DateTime parseStringToDate(String dateString) {
  return DateTime.parse(dateString);
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor ingresa tu correo electrónico';
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
  if (value.length < 8) {
    return 'La contraseña debe tener al menos 8 caracteres';
  }
  return null;
}

String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor ingresa tu nombre';
  }
  if (value.length < 3) {
    return 'El nombre debe tener al menos 3 caracteres';
  }
  return null;
}

String? validateBirthdate(String? value) {
  if (value == null || value.isEmpty) {
    return 'Campo faltante';
  }
  return null;
}
