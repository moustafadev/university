import 'package:equatable/equatable.dart';
import 'package:heart_disease_prediction/features/howe/data/models/news_model.dart';

// ignore: must_be_immutable
class NewsListEntity extends Equatable {
  NewsListEntity({
    this.success,
    this.news,
  });
  bool? success;
  List<NewsModel>? news;
  @override
  List<Object?> get props => [success, news];
}

// ignore: must_be_immutable
class NewsEntity extends Equatable {
  NewsEntity({
    this.title,
    this.link,
    this.imageUrl,
    this.description,
  });
  String? title;
  String? link;
  String? imageUrl;
  String? description;

  @override
  // TODO: implement props
  List<Object?> get props => [
        title,
        link,
        imageUrl,
        description,
      ];
}
