import 'package:dartz/dartz.dart';
import 'package:heart_disease_prediction/core/error/Failure.dart';
import 'package:heart_disease_prediction/features/howe/data/models/news_model.dart';
import 'package:heart_disease_prediction/features/howe/data/repositories/news_repo.dart';

class NewsUseCase {
  final NewsRepository newsRepository;
  NewsUseCase({required this.newsRepository});
  Future<Either<Failure, NewsListModel>> call() async {
    return await newsRepository.getNews();
  }
}
