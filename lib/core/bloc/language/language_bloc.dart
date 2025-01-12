import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'language_event.dart';

class LanguageBloc extends Bloc<LanguageEvent, Locale> {
  LanguageBloc() : super(const Locale('es')) {
    on<LanguageChanged>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('locale', event.locale.languageCode);
      Intl.defaultLocale = event.locale.languageCode;
      emit(event.locale);
    });
  }
}
