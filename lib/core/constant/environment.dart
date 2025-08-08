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
  static String product = '$apiUrl${dotenv.env['product']}';
  static String employeeInfo = '$apiUrl${dotenv.env['employeeInfo']}';
  static String getAppointments = '$apiUrl${dotenv.env['getAppointments']}';
  static String orderProductItem = '$apiUrl${dotenv.env['orderProductItem']}';
  static String publicity = '$apiUrl${dotenv.env['publicity']}';
  static String chat = '$apiUrl${dotenv.env['chat']}';
  static String userChatMessage = '$apiUrl${dotenv.env['userChatMessage']}';
  static String fcmToken = '$apiUrl${dotenv.env['fcmToken']}';
  static String comments = '$apiUrl${dotenv.env['comments']}';
  static String notifications = '$apiUrl${dotenv.env['notifications']}';
  static String admin = '$apiUrl${dotenv.env['admin']}';
  static String userFilter = '$apiUrl${dotenv.env['userFilter']}';
  static String addCard = '$apiUrl${dotenv.env['addCard']}';
  static String debit = '$apiUrl${dotenv.env['debit']}';
  static String payment = '$apiUrl${dotenv.env['payment']}';
}
