import 'package:flutter/material.dart';
import 'package:flutter_wan/ui/base/BaseWidget.dart';

class ProjectPage extends BaseWidget {
  @override
  BaseWeidgetState<BaseWidget> createBaseState() {
    return ProjectPageState();
  }
}

class ProjectPageState extends BaseWeidgetState {
  @override
  void initState() {}

  @override
  attachContentWeidget(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('我是项目'),
          OutlinedButton(onPressed: () => {
            showLoading()
          }, child: Text("loading")),

          OutlinedButton(onPressed: () => {
            showContent()
          }, child: Text("content")),

          OutlinedButton(onPressed: () => {
            showNetworkError()
          }, child: Text("networkError")),

          OutlinedButton(onPressed: () => {
            showEmpty()
          }, child: Text("empty")),

        ],
      ),
    );
  }

  @override
  void onClickErrorWidget() {
    showLoading();
  }


}
