import 'package:dio/dio.dart';
import 'package:heart_disease_prediction/core/datasources/api_base.dart';
import 'package:heart_disease_prediction/features/howe/data/models/news_model.dart';

class ApiServiceHome extends ApiBase {
  Future<NewsListModel> getNews() async {
    try {
      final response = await get('/scrape-google-news/?search_query=сердечно');
      // print(response.json);
      if (response.statusCode == 200) {
        final res = NewsListModel.fromJson(response.json);
        return res;
      } else {
        throw Exception(response.json['message']);
      }
    } on DioError catch (error) {
      print(error.response?.data);
      throw Exception(error.response?.data['message']);
    } on Exception catch (error, s) {
      print(s);
      throw Exception(error.toString());
    }
  }
}
