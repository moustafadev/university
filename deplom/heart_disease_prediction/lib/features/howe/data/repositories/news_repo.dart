import 'package:dartz/dartz.dart';
import 'package:heart_disease_prediction/core/error/Failure.dart';
import 'package:heart_disease_prediction/core/error/exception.dart';
import 'package:heart_disease_prediction/core/network/network_info.dart';
import 'package:heart_disease_prediction/features/howe/data/datasources/api_datasources/api_service_home.dart';
import 'package:heart_disease_prediction/features/howe/data/datasources/local_datasorce/news_local.dart';
import 'package:heart_disease_prediction/features/howe/data/models/news_model.dart';
import 'package:heart_disease_prediction/features/howe/domain/repositories/news_repository_impl.dart';

class NewsRepository implements NewsRepositoryImpl {
  ApiServiceHome apiServiceHome;
  final NetworkChecker networkInfoImpl;
  final NewsLocalImpl newsLocalImpl;
  NewsRepository({
    required this.apiServiceHome,
    required this.networkInfoImpl,
    required this.newsLocalImpl,
  });
  @override
  Future<Either<Failure, NewsListModel>> getNews() async {
    if (await networkInfoImpl.isConnected) {
      try {
        final res = await apiServiceHome.getNews();
        await newsLocalImpl.cacheNews(res);
        return Right(res);
      } on ServerException {
        throw Left(ServerFailure());
      }
    } else {
      final result = await apiServiceHome.getNews();
      return Right(result);
    }
  }
}
