import 'package:antonella/core/bloc/bloc.dart';
import 'package:antonella/core/constant/constant.dart';
import 'package:antonella/core/constant/environment.dart';
import 'package:antonella/core/l10n/app_localizations.dart';
import 'package:antonella/core/router/router.dart';
import 'package:antonella/core/theme/theme.dart';
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
    TextTheme textTheme = createTextTheme(context, "Rubik", "Rubik");
    MaterialTheme theme = MaterialTheme(textTheme);
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => di.sl<ThemeBloc>()),
          BlocProvider(create: (context) => di.sl<LanguageBloc>()),
          BlocProvider(create: (context) => di.sl<UserBloc>()),
          BlocProvider(create: (context) => di.sl<ServiceBloc>()),
          BlocProvider(create: (context) => di.sl<ServicesSelectedBloc>()),
          BlocProvider(create: (context) => di.sl<ServiceFormBloc>()),
          BlocProvider(create: (context) => di.sl<PasswordBloc>()),
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
                theme: stateTheme ? theme.lightMediumContrast() : theme.lightMediumContrast());
          });
        }));
  }
}
