import 'package:get_it/get_it.dart';
import 'package:heart_disease_prediction/core/network/network_info.dart';
import 'package:heart_disease_prediction/features/howe/data/datasources/api_datasources/api_service_home.dart';
import 'package:heart_disease_prediction/features/howe/data/datasources/local_datasorce/news_local.dart';
import 'package:heart_disease_prediction/features/howe/data/repositories/news_repo.dart';
import 'package:heart_disease_prediction/features/howe/domain/repositories/news_repository_impl.dart';
import 'package:heart_disease_prediction/features/howe/domain/usecases/news_use_case.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/datasources/cache_helper.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  //BLOC

  // locator.registerFactory(() => AuthBloc(authUseCase: locator()));

  // //USECASES
  locator.registerLazySingleton(() => NewsUseCase(newsRepository: locator()));

  // //CORE
  locator.registerLazySingleton(() => NetworkChecker(locator()));

  //
  // //REPOSITORISE
  locator.registerLazySingleton<NewsRepository>(
    () => NewsRepository(
      apiServiceHome: locator(),
      networkInfoImpl: locator(),
      newsLocalImpl: locator(),
    ),
  );

  // //DATASOURSE
  locator.registerLazySingleton(() => ApiServiceHome());
  locator.registerLazySingleton(() => NewsLocalImpl(locator()));

  // //EXTRNAL
  locator.registerLazySingleton(() => SharedPreferences.getInstance());
  locator.registerLazySingleton(() => InternetConnectionChecker());
  locator.registerLazySingleton(() => CacheHelper());
}
