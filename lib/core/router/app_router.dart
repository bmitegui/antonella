import 'package:antonella/core/injection/injection_container.dart';
import 'package:antonella/core/router/app_router_notifier.dart';
import 'package:antonella/core/screens/loading_screen.dart';
import 'package:antonella/core/screens/start_screen.dart';
import 'package:antonella/core/widgets/confirmation_widget.dart';
import 'package:antonella/features/service/presentation/screens/pages_screen.dart';
import 'package:antonella/features/user/presentation/bloc/bloc.dart';
import 'package:antonella/features/user/presentation/screens/sign_in_screen.dart';
import 'package:antonella/features/user/presentation/screens/sign_up_screen.dart';
import 'package:antonella/features/user/presentation/widgets/recover_forgot_password_widget.dart';
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
          path: '/signIn', builder: (context, state) => const SignInScreen()),
      GoRoute(
          path: '/signUp', builder: (context, state) => const SignUpScreen()),
      GoRoute(path: '/pages', builder: (context, state) => const PagesScreen()),
      GoRoute(path: '/forgotPassword', builder:(context, state) => const RecoverForgotPasswordWidget()),
      GoRoute(path: '/confirmation', builder: (context, state) => const ConfirmationWidget())
    ],
    redirect: (context, state) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      bool hasSeenStartScreen =
          preferences.getBool('hasSeenStartScreen') ?? false;
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
        } else if (isGoingTo == '/signUp') {
          return '/signUp';
        } else if (isGoingTo == '/forgotPassword') {
          return '/forgotPassword';
        } else if (isGoingTo == '/confirmation') {
          return '/confirmation';
        } else if (isGoingTo != '/signIn') {
          return '/signIn';
        }
      }
      return null;
    });
