import 'package:flutter/cupertino.dart';
import 'package:flutter_wan/api/apis.dart';
import 'package:flutter_wan/model/artical_model.dart';
import 'package:flutter_wan/net/dio_manager.dart';
import 'package:flutter_wan/model/wx_chapter_model.dart';


ApiService _apiService = new ApiService();

ApiService get apiService => _apiService;


class ApiService {

  //获取广场数据
  void getSquareList(
      Function callback, Function errorCallback, int _page) async {
    dio.get(Apis.SQUARE_LIST + "/$_page/json")
        .then((reponse) => callback(ArticleModel.fromJson(reponse.data)));
  }

  /// 获取公众号名称
  void getWXChaptersList(Function callback, Function errorCallback) async {
    dio.get(Apis.WX_CHAPTERS_LIST).then((response) {
      callback(WxChapterModel.fromJson(response.data));
    }).catchError((e) {
      errorCallback(e);
    });
  }


}
