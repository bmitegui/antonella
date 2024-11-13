import 'package:antonella/core/network/network.dart';
import 'package:antonella/features/user/data/datasources/datasources.dart';
import 'package:antonella/features/user/data/repositories/repositories.dart';
import 'package:antonella/features/user/domain/repositories/repositories.dart';
import 'package:antonella/features/user/domain/usecases/usecases.dart';
import 'package:antonella/features/user/presentation/bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Core

  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  Hive.init((await getApplicationDocumentsDirectory()).path);
  sl.registerLazySingleton<Box<dynamic>>(() => Hive.box('UserModel'),
      instanceName: 'UserModel');
  await Hive.openBox('UserModel');

  //! Data sources
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl<Dio>()));
  sl.registerLazySingleton<UserLocalDataSource>(() => UserLocalDataSourceImpl(
      box: sl<Box<dynamic>>(instanceName: 'UserModel')));

  //! Repository
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      networkInfo: sl<NetworkInfo>(),
      userRemoteDataSource: sl<UserRemoteDataSource>(),
      userLocalDataSource: sl<UserLocalDataSource>()));

  //! Use cases
  sl.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(userRepository: sl<UserRepository>()));
  sl.registerLazySingleton<CheckAuthenticationUseCase>(
      () => CheckAuthenticationUseCase(userRepository: sl<UserRepository>()));
  sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(userRepository: sl<UserRepository>()));
  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(userRepository: sl<UserRepository>()));

  //! Blocs
  sl.registerLazySingleton<UserBloc>(() => UserBloc(
      signInUseCase: sl<SignInUseCase>(),
      signUpUseCase: sl<SignUpUseCase>(),
      signOutUseCase: sl<SignOutUseCase>(),
      checkAuthenticationUseCase: sl<CheckAuthenticationUseCase>()));
}
