import 'package:api/api.dart';

class NewsRepository {
  Future<dynamic> getNews() async {
    final response = await ApiSdk.getNews();
    return response;
  }

  Future<dynamic> getTopNews() async {
    final response = await ApiSdk.getTopNews();
    return response;
  }
}
