import 'package:flutter_wan/api/apis.dart';
import 'package:flutter_wan/model/artical_model.dart';
import 'package:flutter_wan/net/dio_manager.dart';


ApiService _apiService = new ApiService();

ApiService get apiService => _apiService;


class ApiService {
  void getSquareList(
      Function callback, Function errorCallback, int _page) async {
    dio.get(Apis.SQUARE_LIST + "/$_page/json")
        .then((reponse) => callback(ArticleModel.fromJson(reponse.data)));
  }
}
