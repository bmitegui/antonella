import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/router/app_router_notifier.dart';
import 'package:antonella/core/screens/loading_screen.dart';
import 'package:antonella/core/screens/notification_screen.dart';
import 'package:antonella/core/screens/start_screen.dart';
import 'package:antonella/core/services/firebase_messaging_service.dart';
import 'package:antonella/core/services/local_notifications_service.dart';
import 'package:antonella/core/utils/util.dart';
import 'package:antonella/features/user/presentation/screens/confirmation_screen.dart';
import 'package:antonella/core/screens/pages_screen.dart';
import 'package:antonella/features/user/presentation/bloc/bloc.dart';
import 'package:antonella/features/user/presentation/screens/sign_in_screen.dart';
import 'package:antonella/features/user/presentation/screens/sign_up_screen.dart';
import 'package:antonella/features/user/presentation/screens/recover_forgot_password_screen.dart';
import 'package:antonella/features/user/presentation/screens/reset_password_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userBloc = sl<UserBloc>();
final userBlocListenable = UserBlocListenable(userBloc);

final appRouter = GoRouter(
    initialLocation: '/loading',
    refreshListenable: userBlocListenable,
    routes: [
      GoRoute(
          path: '/loading', builder: (context, state) => const LoadingScreen()),
      GoRoute(path: '/start', builder: (context, state) => const StartScreen()),
      GoRoute(
          path: '/notification',
          builder: (context, state) => const NotificationScreen()),
      GoRoute(
          path: '/signIn', builder: (context, state) => const SignInScreen()),
      GoRoute(
          path: '/signUp', builder: (context, state) => const SignUpScreen()),
      GoRoute(path: '/pages', builder: (context, state) => const PagesScreen()),
      GoRoute(
          path: '/forgotPassword',
          builder: (context, state) => const RecoverForgotPasswordScreen()),
      GoRoute(
          path: '/confirmation',
          builder: (context, state) => const ConfirmationScreen()),
      GoRoute(
          path: '/resetPassword',
          builder: (context, state) => const ResetPasswordScreen())
    ],
    redirect: (context, state) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      bool hasSeenStartScreen =
          preferences.getBool('hasSeenStartScreen') ?? false;
      bool isNotificationGranted = await isNotificationPermissionGranted();
      final isGoingTo = state.fullPath;

      if (userBloc.state is UserLoading) {
        return null;
      } else if (userBloc.state is UserAuthenticated) {
        if (isGoingTo == '/signIn' ||
            isGoingTo == '/signUp' ||
            isGoingTo == '/loading') {
          return '/pages';
        }
      } else if (userBloc.state is UserUnauthenticated) {
        if (!hasSeenStartScreen) {
          return '/start';
        } else {
          if (!isNotificationGranted) {
            await preferences.setBool('isFirebaseNotificationInit', false);
            return '/notification';
          } else {
            await sl<LocalNotificationsService>().init();
            await sl<FirebaseMessagingService>().init(
                localNotificationsService: sl<LocalNotificationsService>());
          }
          if (isGoingTo == '/signUp') {
            return '/signUp';
          } else if (isGoingTo == '/forgotPassword') {
            return '/forgotPassword';
          } else if (isGoingTo == '/confirmation') {
            return '/confirmation';
          } else if (isGoingTo == '/resetPassword') {
            return '/resetPassword';
          } else if (isGoingTo != '/signIn') {
            return '/signIn';
          }
        }
      }
      return null;
    });
