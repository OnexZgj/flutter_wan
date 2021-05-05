import 'package:flutter/material.dart';
import 'package:flutter_wan/ui/HomePage.dart';
import 'package:flutter_wan/ui/ProjectPage.dart';
import 'package:flutter_wan/ui/SquarePage.dart';
import 'package:flutter_wan/ui/SystermPage.dart';
import 'package:flutter_wan/ui/WechartPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainHomePage(),
    );
  }
}

class MainHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State {
  int _currentIndex = 0;

  var pages = <Widget>[
    HomePage(),
    ProjectPage(),
    SquarePage(),
    SystermPage(),
    WechartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    //去掉debug图标
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(title: Text('wanandroid')),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(label: "首页", icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  label: "广场", icon: Icon(Icons.assignment)),
              BottomNavigationBarItem(label: "公众号", icon: Icon(Icons.chat)),
              BottomNavigationBarItem(
                  label: "体系", icon: Icon(Icons.assignment)),
              BottomNavigationBarItem(label: "项目", icon: Icon(Icons.book)),
            ],
            onTap: _onTapChanged,
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
          ),
          body: pages[_currentIndex]
        ),
        onWillPop: null);
  }

  void _onTapChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
