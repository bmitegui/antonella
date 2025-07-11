import 'package:antonella/core/bloc/bloc.dart';
import 'package:antonella/core/constant/constant.dart';
import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/router/router.dart';
import 'package:antonella/core/services/firebase_options.dart';
import 'package:antonella/core/theme/theme.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:antonella/features/service/presentation/bloc/promotions/promotion_bloc.dart';
import 'package:antonella/features/service/presentation/promotion_cart/promotion_cart_bloc.dart';
import 'package:antonella/features/user/presentation/bloc/bloc.dart';
import 'package:antonella/core/injection/injection_container.dart' as di;
import 'package:antonella/features/user/presentation/bloc/message/message_bloc.dart';
import 'package:antonella/features/user/presentation/bloc/send_message/send_message_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'features/product/presentation/bloc/bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();
  await Environment.initializeEnv();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
      (value) => runApp(const SafeArea(
          child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light, child: MyApp()))));
  userBloc.add(CheckAuthenticationEvent());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MaterialTheme theme = const MaterialTheme();

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => di.sl<ThemeBloc>()),
          BlocProvider(create: (context) => di.sl<LanguageBloc>()),
          BlocProvider(create: (context) => di.sl<UserBloc>()),
          BlocProvider(create: (context) => di.sl<ServiceBloc>()),
          BlocProvider(create: (context) => di.sl<ServicesSelectedBloc>()),
          BlocProvider(create: (context) => di.sl<PasswordBloc>()),
          BlocProvider(create: (context) => di.sl<CommentBloc>()),
          BlocProvider(create: (context) => di.sl<ServiceFormBloc>()),
          BlocProvider(create: (context) => di.sl<SendRequestBloc>()),
          BlocProvider(create: (context) => di.sl<ProductsBloc>()),
          BlocProvider(create: (context) => di.sl<ProductsSelectedBloc>()),
          BlocProvider(create: (context) => di.sl<EmployeeInfoBloc>()),
          BlocProvider(create: (context) => di.sl<OrdersBloc>()),
          BlocProvider(create: (context) => di.sl<CartBloc>()),
          BlocProvider(create: (context) => di.sl<PayOrderBloc>()),
          BlocProvider(create: (context) => di.sl<MessagesBloc>()),
          BlocProvider(create: (context) => di.sl<SendMessageBloc>()),
          BlocProvider(create: (context) => di.sl<FormDoneBloc>()),
          BlocProvider(create: (context) => di.sl<StartAppointmentBloc>()),
          BlocProvider(create: (context) => di.sl<PromotionBloc>()),
          BlocProvider(create: (context) => di.sl<PromotionCartBloc>()),
        ],
        child: BlocBuilder<ThemeBloc, bool>(builder: (context, stateTheme) {
          return BlocBuilder<LanguageBloc, Locale>(
              builder: (context, stateLanguage) {
            return MaterialApp.router(
                locale: stateLanguage,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate
                ],
                supportedLocales: supportedLocales,
                routeInformationParser: appRouter.routeInformationParser,
                routerDelegate: appRouter.routerDelegate,
                routeInformationProvider: appRouter.routeInformationProvider,
                debugShowCheckedModeBanner: false,
                title: appName,
                theme: stateTheme ? theme.light(context) : theme.dark(context));
          });
        }));
  }
}
