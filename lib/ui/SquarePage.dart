import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan/api/apis_services.dart';
import '../model/artical_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../common/common.dart';

class SquarePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SquarePageState();
  }
}



class SquarePageState extends State<SquarePage> {

  //ListView的滑动监听事件
  ScrollController _scrollController = new ScrollController();

  RefreshController _refreshController = new RefreshController(initialRefresh: false);


  /// 首页文章列表数据
  List<ArticleBean> _articles = new List();

  /// 页码，从0开始
  int _page = 0;

  Widget itemView(BuildContext context, int index) {
    if (index > _articles.length) return null;
    var article = _articles[index];
    return ItemArticalList(item: article);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullUp: true,
        enablePullDown: true,
        onRefresh: getSquareList,
        onLoading: getMoreSquareList,
        controller: _refreshController,
        child: ListView.builder(
          itemBuilder: itemView,
          itemCount: _articles.length,
          controller: _scrollController,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getSquareList();
    _scrollController.addListener(() {
      // if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
      //   //获取更多
      //   getMoreSquareList();
      //   debugPrint("xxxxxx");
      // }
      // if(_scrollController.position.pixels == 0){
      //   _articles.clear();
      //   getSquareList();
      // }
    });
  }


  //获取更多数据
  Future getMoreSquareList() async {
    _page++;
    debugPrint("xxxxxx: $_page");
    apiService.getSquareList((ArticleModel model){
      if(model.errorCode == Constants.STATUS_SUCCESS){
        if(model.data.datas.length>0){
          _refreshController.loadComplete();
          setState(() {
            _articles.addAll(model.data.datas);
          });
        }
      }

    }, (DioError error){

    }, _page);
  }


  Future getSquareList() async {
    _page = 0;
    apiService.getSquareList((ArticleModel model) {
      if(model.errorCode == Constants.STATUS_SUCCESS){
        if(model.data.datas.length>0){
          _refreshController.refreshCompleted(resetFooterState: true);
          setState(() {
            _articles.addAll(model.data.datas);
          });
        }
      }
    }, (DioError error) {
      debugPrint(error.message);
    }, _page);
  }
}

class ItemArticalList extends StatefulWidget {
  ArticleBean item;

  ItemArticalList({this.item});

  @override
  State<StatefulWidget> createState() {
    return ItemArticalState();
  }
}

//写上泛型以后，才会识别widget.item的语法
class ItemArticalState extends State<ItemArticalList> {
  @override
  Widget build(BuildContext context) {
    var item = widget.item;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(item.author, style: TextStyle(color: Colors.deepPurple))
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Text(item.title, style: TextStyle(color: Colors.deepPurple))],
          ),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Text(item.niceDate, style: TextStyle(color: Colors.deepPurple))],
          ),
        ),
        Divider(height: 2)
      ],
    );
  }
}
