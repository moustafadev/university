import 'package:heart_disease_prediction/features/howe/domain/entities/news_entity.dart';

// ignore: must_be_immutable
class NewsListModel extends NewsListEntity {
  NewsListModel({
    super.news,
    super.success,
  });
  NewsListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    news = json['news'] != null
        ? List.from(json['news']).map((e) => NewsModel.fromJson(e)).toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['news'] = news != null ? news!.map((e) => e).toList() : null;
    return _data;
  }
}

// ignore: must_be_immutable
class NewsModel extends NewsEntity {
  NewsModel({
    super.description,
    super.imageUrl,
    super.link,
    super.title,
  });

  NewsModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    link = json['link'];
    imageUrl = json['image_url'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['link'] = link;
    _data['image_url'] = imageUrl;
    _data['description'] = description;
    return _data;
  }
}
