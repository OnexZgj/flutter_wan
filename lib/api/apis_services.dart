import 'package:flutter/cupertino.dart';
import 'package:flutter_wan/api/apis.dart';
import 'package:flutter_wan/model/artical_model.dart';
import 'package:flutter_wan/model/project_tree_model.dart';
import 'package:flutter_wan/model/wx_artical_item.dart';
import 'package:flutter_wan/net/dio_manager.dart';
import 'package:flutter_wan/model/wx_chapter_model.dart';


ApiService _apiService = new ApiService();

ApiService get apiService => _apiService;


class ApiService {

  //获取广场数据
  void getSquareList(Function callback, Function errorCallback,
      int _page) async {
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


  /// 获取公众号文章列表数据
  void getWxArticalList(Function callback, Function errorCallback, int _id,
      int _page) async {
    dio.get(Apis.WX_ARTICLE_LIST + "/$_id/$_page/json").then((response) {
      callback(WxArticalItemModel.fromJson(response.data));
    }).catchError((e) {
      errorCallback(e);
    });
  }

  void getProjectTreeList(Function callback, Function errorCallback) async {
    dio.get(Apis.PROJECT_TREE_LIST).then((value) {
      callback(ProjectTreeModel.fromJson(value.data));
    }).catchError((e){
      errorCallback(e);
    });
  }


}
