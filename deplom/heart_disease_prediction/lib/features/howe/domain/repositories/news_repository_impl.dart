import 'package:heart_disease_prediction/core/error/Failure.dart';
import 'package:heart_disease_prediction/features/howe/data/models/news_model.dart';
import 'package:dartz/dartz.dart';

abstract class NewsRepositoryImpl {
  Future<Either<Failure, NewsListModel>> getNews();
}
