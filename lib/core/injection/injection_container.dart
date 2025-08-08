import 'package:antonella/core/bloc/bloc.dart';
import 'package:antonella/core/constant/constant.dart';
import 'package:antonella/core/network/network.dart';
import 'package:antonella/core/services/firebase_messaging_service.dart';
import 'package:antonella/core/services/local_notifications_service.dart';
import 'package:antonella/core/services/services.dart';
import 'package:antonella/features/product/data/datasources/remote/products_remote_datasource.dart';
import 'package:antonella/features/product/data/repositories/products_repository_impl.dart';
import 'package:antonella/features/product/domain/usecases/usecases.dart';
import 'package:antonella/features/product/presentation/bloc/bloc.dart';
import 'package:antonella/features/service/data/datasources/datasources.dart';
import 'package:antonella/features/service/data/repositories/repositories.dart';
import 'package:antonella/features/service/domain/repositories/repositories.dart';
import 'package:antonella/features/product/domain/repositories/repositories.dart';
import 'package:antonella/features/service/domain/usecases/get_promotions_use_case.dart';
import 'package:antonella/features/service/domain/usecases/usecases.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
import 'package:antonella/features/service/presentation/bloc/promotions/promotion_bloc.dart';
import 'package:antonella/features/user/data/datasources/datasources.dart';
import 'package:antonella/features/user/data/repositories/repositories.dart';
import 'package:antonella/features/user/domain/repositories/repositories.dart';
import 'package:antonella/features/user/domain/usecases/send_messages_use_case.dart';
import 'package:antonella/features/user/domain/usecases/usecases.dart';
import 'package:antonella/features/user/presentation/bloc/bloc.dart';
import 'package:antonella/features/user/presentation/bloc/message/message_bloc.dart';
import 'package:antonella/features/user/presentation/bloc/profile_user/profile_user_bloc.dart';
import 'package:antonella/features/user/presentation/bloc/send_message/send_message_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Core
  SharedPreferences prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton(() => KeyValueStorageServiceImpl());

  sl.registerLazySingleton<InternetConnection>(() => InternetConnection());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  Hive.init((await getApplicationDocumentsDirectory()).path);
  sl.registerLazySingleton<Box<dynamic>>(() => Hive.box('UserModel'),
      instanceName: 'UserModel');
  await Hive.openBox('UserModel');

  sl.registerLazySingleton<LocalNotificationsService>(
      () => LocalNotificationsService.instance());
  sl.registerLazySingleton<FirebaseMessagingService>(
      () => FirebaseMessagingService.instance());

  //! Data sources
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl<Dio>()));
  sl.registerLazySingleton<UserLocalDataSource>(() => UserLocalDataSourceImpl(
      box: sl<Box<dynamic>>(instanceName: 'UserModel')));
  sl.registerLazySingleton<ServiceRemoteDataSource>(
      () => ServiceRemoteDataSourceImpl(client: sl<Dio>()));
  sl.registerLazySingleton<ProductsRemoteDataSource>(
      () => ProductsRemoteDataSourceImpl(client: sl<Dio>()));

  //! Repository
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      networkInfo: sl<NetworkInfo>(),
      userRemoteDataSource: sl<UserRemoteDataSource>(),
      userLocalDataSource: sl<UserLocalDataSource>()));

  sl.registerLazySingleton<ServiceRepository>(() => ServiceRepositoryImpl(
      networkInfo: sl<NetworkInfo>(),
      serviceRemoteDataSource: sl<ServiceRemoteDataSource>()));

  sl.registerLazySingleton<ProductsRepository>(() => ProductsRepositoryImpl(
      networkInfo: sl<NetworkInfo>(),
      productsRemoteDataSource: sl<ProductsRemoteDataSource>()));

  //! Use cases
  sl.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(userRepository: sl<UserRepository>()));
  sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(userRepository: sl<UserRepository>()));
  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(userRepository: sl<UserRepository>()));

  sl.registerLazySingleton<GetServicesUseCase>(
      () => GetServicesUseCase(serviceRepository: sl<ServiceRepository>()));

  sl.registerLazySingleton<PasswordCodeUseCase>(
      () => PasswordCodeUseCase(userRepository: sl<UserRepository>()));

  sl.registerLazySingleton<PasswordResetUseCase>(
      () => PasswordResetUseCase(userRepository: sl<UserRepository>()));

  sl.registerLazySingleton<GetServiceCommentsUseCase>(() =>
      GetServiceCommentsUseCase(serviceRepository: sl<ServiceRepository>()));

  sl.registerLazySingleton<SendRequestUseCase>(
      () => SendRequestUseCase(serviceRepository: sl<ServiceRepository>()));

  sl.registerLazySingleton<GetProductsUseCase>(
      () => GetProductsUseCase(productsRepository: sl<ProductsRepository>()));

  sl.registerLazySingleton<GetEmployeeInfoUseCase>(
      () => GetEmployeeInfoUseCase(userRepository: sl<UserRepository>()));

  sl.registerLazySingleton<GetOrdersUseCase>(
      () => GetOrdersUseCase(serviceRepository: sl<ServiceRepository>()));

  sl.registerLazySingleton<GetCartItemsUseCase>(
      () => GetCartItemsUseCase(productRepository: sl<ProductsRepository>()));

  sl.registerLazySingleton<PayOrderUseCase>(
      () => PayOrderUseCase(serviceRepository: sl<ServiceRepository>()));

  sl.registerLazySingleton<GetMessagesUseCase>(
      () => GetMessagesUseCase(userRepository: sl<UserRepository>()));

  sl.registerLazySingleton<SendMessagesUseCase>(
      () => SendMessagesUseCase(userRepository: sl<UserRepository>()));

  sl.registerLazySingleton<GetFormDoneUseCase>(
      () => GetFormDoneUseCase(serviceRepository: sl<ServiceRepository>()));

  sl.registerLazySingleton<StartAppointmentUseCase>(() =>
      StartAppointmentUseCase(serviceRepository: sl<ServiceRepository>()));

  sl.registerLazySingleton<EndAppointmentUseCase>(
      () => EndAppointmentUseCase(serviceRepository: sl<ServiceRepository>()));

  sl.registerLazySingleton<GetPromotionsUseCase>(
      () => GetPromotionsUseCase(serviceRepository: sl<ServiceRepository>()));

  sl.registerLazySingleton<GetNotificationsUseCase>(() =>
      GetNotificationsUseCase(serviceRepository: sl<ServiceRepository>()));

  sl.registerLazySingleton<GetAdminUseCase>(
      () => GetAdminUseCase(userRepository: sl<UserRepository>()));

  sl.registerLazySingleton<GetEmployeesUseCase>(
      () => GetEmployeesUseCase(userRepository: sl<UserRepository>()));

  sl.registerLazySingleton<GetProfileUserUseCase>(
      () => GetProfileUserUseCase(userRepository: sl<UserRepository>()));

  sl.registerLazySingleton<AddCardUseCase>(
      () => AddCardUseCase(userRepository: sl<UserRepository>()));

  sl.registerLazySingleton<DebitCardUseCase>(
      () => DebitCardUseCase(userRepository: sl<UserRepository>()));

  sl.registerLazySingleton<GetCardsUseCase>(
      () => GetCardsUseCase(userRepository: sl<UserRepository>()));

  sl.registerLazySingleton<GetPromotionsRelatedUseCase>(() =>
      GetPromotionsRelatedUseCase(serviceRepository: sl<ServiceRepository>()));

  //! Blocs
  sl.registerLazySingleton<UserBloc>(() => UserBloc(
      keyValueStorageService: sl<KeyValueStorageServiceImpl>(),
      signInUseCase: sl<SignInUseCase>(),
      signUpUseCase: sl<SignUpUseCase>(),
      signOutUseCase: sl<SignOutUseCase>()));

  sl.registerLazySingleton<ServiceBloc>(
      () => ServiceBloc(getServicesUseCase: sl<GetServicesUseCase>()));

  sl.registerLazySingleton<ServicesSelectedBloc>(() => ServicesSelectedBloc());

  sl.registerLazySingleton<PasswordBloc>(() => PasswordBloc(
      passwordCodeUseCase: sl<PasswordCodeUseCase>(),
      passwordResetUseCase: sl<PasswordResetUseCase>()));

  sl.registerLazySingleton<CommentBloc>(
      () => CommentBloc(getCommentsUseCase: sl<GetServiceCommentsUseCase>()));

  sl.registerLazySingleton<ServiceFormBloc>(() => ServiceFormBloc());

  sl.registerLazySingleton<SendRequestBloc>(
      () => SendRequestBloc(getSendRequestsUseCase: sl<SendRequestUseCase>()));

  sl.registerLazySingleton<ProductsBloc>(
      () => ProductsBloc(getProductsUseCase: sl<GetProductsUseCase>()));

  sl.registerLazySingleton<ProductsSelectedBloc>(() => ProductsSelectedBloc());

  sl.registerLazySingleton<EmployeeInfoBloc>(() =>
      EmployeeInfoBloc(getEmployeeInfoUseCase: sl<GetEmployeeInfoUseCase>()));

  sl.registerLazySingleton<OrdersBloc>(
      () => OrdersBloc(getOrderssUseCase: sl<GetOrdersUseCase>()));

  sl.registerLazySingleton<CartBloc>(
      () => CartBloc(getCartItemsUseCase: sl<GetCartItemsUseCase>()));

  sl.registerLazySingleton<PayOrderBloc>(
      () => PayOrderBloc(payOrderUseCase: sl<PayOrderUseCase>()));

  sl.registerLazySingleton<MessagesBloc>(
      () => MessagesBloc(getMessagesUseCase: sl<GetMessagesUseCase>()));

  sl.registerLazySingleton<SendMessageBloc>(
      () => SendMessageBloc(sendMessagesUseCase: sl<SendMessagesUseCase>()));

  sl.registerLazySingleton<FormDoneBloc>(
      () => FormDoneBloc(getFormDoneUseCase: sl<GetFormDoneUseCase>()));

  sl.registerLazySingleton<StartAppointmentBloc>(() => StartAppointmentBloc(
      startAppointmentUseCase: sl<StartAppointmentUseCase>()));

  sl.registerLazySingleton<EndAppointmentBloc>(() =>
      EndAppointmentBloc(endAppointmentUseCase: sl<EndAppointmentUseCase>()));

  sl.registerLazySingleton<PromotionBloc>(
      () => PromotionBloc(getPromotionsUseCase: sl<GetPromotionsUseCase>()));

  sl.registerLazySingleton<PromotionCartBloc>(() => PromotionCartBloc(
      getPromotionsRelated: sl<GetPromotionsRelatedUseCase>()));

  sl.registerLazySingleton<NotificationsBloc>(() => NotificationsBloc(
      getNotificationsUseCase: sl<GetNotificationsUseCase>()));

  sl.registerLazySingleton<AdminBloc>(
      () => AdminBloc(getAdminUseCase: sl<GetAdminUseCase>()));

  sl.registerLazySingleton<EmployeesBloc>(
      () => EmployeesBloc(getEmployeesUseCase: sl<GetEmployeesUseCase>()));

  sl.registerLazySingleton<ProfileUserBloc>(() =>
      ProfileUserBloc(getProfileUserUseCase: sl<GetProfileUserUseCase>()));

  sl.registerLazySingleton<CardBloc>(() => CardBloc(
      addCardUseCase: sl<AddCardUseCase>(),
      debitCardUseCase: sl<DebitCardUseCase>()));

  sl.registerLazySingleton<CardsBloc>(
      () => CardsBloc(getCardsUseCase: sl<GetCardsUseCase>()));

  // Theme
  sl.registerLazySingleton<ThemeBloc>(() => ThemeBloc());
  //Language
  sl.registerLazySingleton<LanguageBloc>(() => LanguageBloc());

  // Initialize Theme
  bool isDark = false;
  final prefsIsDark = prefs.getBool('isDark');
  if (prefsIsDark != null) {
    isDark = prefsIsDark;
  } else {
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    isDark = brightness == Brightness.dark;
  }
  sl<ThemeBloc>().add(ThemeChanged(isDark));

  // Initialize Language
  String defaultLocale = 'en';
  final prefsDefaultLocale = prefs.getString('locale');
  if (prefsDefaultLocale != null) {
    defaultLocale = prefsDefaultLocale;
  } else {
    final locale = WidgetsBinding.instance.platformDispatcher.locale;
    defaultLocale = locale.languageCode;
  }
  Intl.defaultLocale = defaultLocale;
  Locale locale = Locale(defaultLocale);
  if (!supportedLocales.contains(locale)) {
    locale = supportedLocales[0];
  }
  sl<LanguageBloc>().add(LanguageChanged(locale));
}
