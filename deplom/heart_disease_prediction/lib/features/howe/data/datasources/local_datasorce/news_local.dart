import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:heart_disease_prediction/core/datasources/cache_helper.dart';
import 'package:heart_disease_prediction/core/styles/string.dart';
import 'package:heart_disease_prediction/features/howe/data/models/news_model.dart';

import '../../../../../core/error/exception.dart';

abstract class NewsLocal {
  Future<NewsModel> getNewsLocal();
  Future<Unit> cacheNews(NewsListModel newsModel);
}

class NewsLocalImpl implements NewsLocal {
  final CacheHelper cacheHelper;

  NewsLocalImpl(this.cacheHelper);

  @override
  Future<Unit> cacheNews(NewsListModel categoryModel) {
    cacheHelper.saveData(
        key: NEWSCACHED, value: json.encode(categoryModel.toJson()));
    return Future.value(unit);
  }

  @override
  Future<NewsModel> getNewsLocal() {
    final categories = cacheHelper.getData(NEWSCACHED);
    if (categories != null) {
      return Future.value(json.decode(categories));
    } else {
      throw EmptyCacheException();
    }
  }
}
