import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static initializeEnv() async {
    await dotenv.load(fileName: '.env');
  }

  static String apiUrl =
      dotenv.env['apiUrl'] ?? 'No está configurado el apiUrl';
  static String signIn = '$apiUrl${dotenv.env['signIn']}';
  static String signUp = '$apiUrl${dotenv.env['signUp']}';
}
