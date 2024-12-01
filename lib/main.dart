import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/router/router.dart';
import 'package:antonella/core/theme/app_theme.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:antonella/features/user/presentation/bloc/bloc.dart';
import 'package:antonella/core/injection/injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => di.sl<UserBloc>()),
          BlocProvider(create: (context) => di.sl<ServiceBloc>()),
          BlocProvider(create: (context) => di.sl<ServicesSelectedBloc>()),
        ],
        child: MaterialApp.router(
            locale: const Locale('es', 'EC'),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            supportedLocales: const [Locale('es', 'EC'), Locale('en', 'US')],
            routeInformationParser: appRouter.routeInformationParser,
            routerDelegate: appRouter.routerDelegate,
            routeInformationProvider: appRouter.routeInformationProvider,
            debugShowCheckedModeBanner: false,
            title: 'Antonella',
            theme: ThemeClass().getTheme(context)));
  }
}
