import 'package:antonella/core/network/network.dart';
import 'package:antonella/core/services/services.dart';
import 'package:antonella/features/service/data/datasources/datasources.dart';
import 'package:antonella/features/service/data/repositories/repositories.dart';
import 'package:antonella/features/service/domain/repositories/repositories.dart';
import 'package:antonella/features/service/domain/usecases/usecases.dart';
import 'package:antonella/features/service/presentation/bloc/bloc.dart';
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
  sl.registerLazySingleton(() => KeyValueStorageServiceImpl());

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

  sl.registerLazySingleton<ServiceRemoteDataSource>(
      () => ServiceRemoteDataSourceImpl(client: sl<Dio>()));

  //! Repository
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      networkInfo: sl<NetworkInfo>(),
      userRemoteDataSource: sl<UserRemoteDataSource>(),
      userLocalDataSource: sl<UserLocalDataSource>()));

  sl.registerLazySingleton<ServiceRepository>(() => ServiceRepositoryImpl(
      networkInfo: sl<NetworkInfo>(),
      serviceRemoteDataSource: sl<ServiceRemoteDataSource>()));

  //! Use cases
  sl.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(userRepository: sl<UserRepository>()));
  sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(userRepository: sl<UserRepository>()));
  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(userRepository: sl<UserRepository>()));

  sl.registerLazySingleton<GetServicesUseCase>(
      () => GetServicesUseCase(serviceRepository: sl<ServiceRepository>()));

  //! Blocs
  sl.registerLazySingleton<UserBloc>(() => UserBloc(
      keyValueStorageService: sl<KeyValueStorageServiceImpl>(),
      signInUseCase: sl<SignInUseCase>(),
      signUpUseCase: sl<SignUpUseCase>(),
      signOutUseCase: sl<SignOutUseCase>()));

  sl.registerLazySingleton<ServiceBloc>(
      () => ServiceBloc(getServicesUseCase: sl<GetServicesUseCase>()));

  sl.registerLazySingleton<ServicesSelectedBloc>(() => ServicesSelectedBloc());
}
