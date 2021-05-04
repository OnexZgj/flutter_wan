import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan/api/apis_services.dart';
import '../model/artical_model.dart';

class SquarePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SquarePageState();
  }
}

class SquarePageState extends State {
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
    return ListView.builder(
      itemBuilder: itemView,
      itemCount: _articles.length,
    );
  }

  @override
  void initState() {
    super.initState();
    getSquareList();
  }

  Future getSquareList() async {
    apiService.getSquareList((ArticleModel model) {
      setState(() {
        _articles.addAll(model.data.datas);
      });
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
