import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan/model/wx_artical_item.dart';
import 'package:flutter_wan/utils/RouterUtils.dart';

class ItemArticalWidget extends StatefulWidget{
  WxArticalBean item;

  ItemArticalWidget({this.item});

  @override
  State<StatefulWidget> createState() {
    return ItemArticalWidgetState();
  }

}

class ItemArticalWidgetState extends State<ItemArticalWidget> {
  @override
  Widget build(BuildContext context) {
    var item = widget.item;
    return InkWell(
      onTap: (){
        RouterUtil.toWebView(context, item.title,item.link);
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(item.author,
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  child: Icon(
                    Icons.favorite,
                    color: Colors.purpleAccent,
                  ),
                ),
                Expanded(
                    child: Text(
                      item.niceDate,
                      textAlign: TextAlign.right,
                    ))
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
            child: Text(
              item.title,
              textAlign: TextAlign.left,
            ),
          ),
          Divider(
            height: 2,
          )
        ],
      ),
    );
  }
}

