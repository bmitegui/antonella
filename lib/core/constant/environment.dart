import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static initializeEnv() async {
    await dotenv.load(fileName: '.env');
  }

  static String apiUrl =
      dotenv.env['apiUrl'] ?? 'No está configurado el apiUrl';
  static String signIn = '$apiUrl${dotenv.env['signIn']}';
  static String signUp = '$apiUrl${dotenv.env['signUp']}';
  static String passwordCode = '$apiUrl${dotenv.env['passwordCode']}';
  static String storeService = '$apiUrl${dotenv.env['store_service']}';
  static String order = '$apiUrl${dotenv.env['order']}';
  static String oderServiceItem = '$apiUrl${dotenv.env['oderServiceItem']}';
  static String answer = '$apiUrl${dotenv.env['answer']}';
  static String user = '$apiUrl${dotenv.env['user']}';
}
