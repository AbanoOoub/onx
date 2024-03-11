import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/features/language/data/data_sources/language_local_data_source.dart';
import 'package:task/features/language/data/repositories/language_repo_impl.dart';
import 'package:task/features/language/domain/repositories/language_repo.dart';
import 'package:task/features/language/domain/use_cases/change_lang_uc.dart';
import 'package:task/features/language/domain/use_cases/get_saved_lang_uc.dart';
import 'package:task/features/language/presentation/manager/language_cubit.dart';
import 'package:task/features/login/data/data_sources/login_remote_data_source.dart';
import 'package:task/features/login/domain/repositories/login_repository.dart';
import 'package:task/features/login/presentation/manager/login_cubit.dart';
import 'package:task/features/orders/data/data_sources/orders_remote_data_source.dart';
import 'package:task/features/orders/domain/repositories/orders_repository.dart';
import 'package:task/features/orders/domain/use_cases/get_order_status_uc.dart';
import 'package:task/features/orders/domain/use_cases/get_orders_uc.dart';
import 'package:task/features/orders/presentation/manager/orders_cubit.dart';
import 'core/api/api_consumer.dart';
import 'core/api/app_interceptors.dart';
import 'core/api/dio_consumer.dart';
import 'core/network/netwok_info.dart';
import 'features/login/data/repositories/login_repository_impl.dart';
import 'features/login/domain/use_cases/login_uc.dart';
import 'features/orders/data/repositories/orders_repository_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features

  /// Blocs
  sl.registerFactory<LanguageCubit>(
      () => LanguageCubit(changeLangUC: sl(), getSavedLangUC: sl()));
  sl.registerFactory<LoginCubit>(
      () => LoginCubit(loginUC: sl(), sharedPreferences: sl()));
  sl.registerFactory<OrdersCubit>(
      () => OrdersCubit(getOrdersUC: sl(), getOrderStatusUC: sl(),sharedPreferences: sl()));

  /// Use cases
  sl.registerLazySingleton<GetSavedLangUC>(
      () => GetSavedLangUC(languageRepository: sl()));
  sl.registerLazySingleton<ChangeLangUC>(
      () => ChangeLangUC(languageRepository: sl()));
  sl.registerLazySingleton<LoginUC>(() => LoginUC(repository: sl()));
  sl.registerLazySingleton<GetOrdersUC>(
      () => GetOrdersUC(ordersRepository: sl()));
  sl.registerLazySingleton<GetOrderStatusUC>(
          () => GetOrderStatusUC(ordersRepository: sl()));


  /// Repository
  sl.registerLazySingleton<LanguageRepository>(
      () => LangRepositoryImpl(langLocalDataSource: sl()));
  sl.registerLazySingleton<LoginRepository>(() =>
      LoginRepositoryImpl( loginRemoteDataSource: sl()));
  sl.registerLazySingleton<OrdersRepository>(() =>
      OrdersRepositoryImpl(ordersRemoteDataSource: sl()));

  /// Data Sources
  sl.registerLazySingleton<LangLocalDataSource>(
      () => LangLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl(apiConsumer: sl()));
  sl.registerLazySingleton<OrdersRemoteDataSource>(
      () => OrdersRemoteDataSourceImpl(apiConsumer: sl()));

  ///! Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));

  ///! External
  SharedPreferences preferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => preferences);
  sl.registerLazySingleton(() => AppInterceptors());
  // sl.registerLazySingleton(() => LogInterceptor(
  //     request: true,
  //     requestBody: true,
  //     requestHeader: true,
  //     responseBody: true,
  //     responseHeader: false,
  //     error: true));
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Dio());
}
