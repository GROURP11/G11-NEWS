/* import 'package:cached_network_image/cached_network_image.dart'; */
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:news1/views/globalnews.dart';
/* import 'package:news1/helper/data.dart';
import 'package:news1/model/article_model.dart';
import 'package:news1/model/category_model.dart';
import 'package:news1/helper/news.dart';
import 'package:news1/views/article_view.dart'; */
import 'package:news1/views/localnews.dart';
import 'package:news1/views/weatherPage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /* bottom navigatio items */

  final items = const [
    Icon(Icons.newspaper_outlined, size: 30),
    Icon(Icons.home, size: 30),
    Icon(Icons.nights_stay, size: 30),
  ];

  int screen = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("G11 ", style: TextStyle(color: Colors.blueGrey)),
              Text(
                "NEWS",
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
          elevation: 0.0,
        ),
        bottomNavigationBar: CurvedNavigationBar(
          items: items,
          index: screen,
          onTap: (selectedScreen) {
            setState(() {
              screen = selectedScreen;
            });
          },
          height: 50,
          backgroundColor: Colors.black,
          animationDuration: const Duration(milliseconds: 300),
        ),
        body: Container(
          /* color: Colors.blue, */
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: getSelectedWidget(screen: screen),
        ));
  }

  Widget getSelectedWidget({required int screen}) {
    Widget widget;
    switch (screen) {
      case 0:
        widget = const LocalNews();
        break;
      case 1:
        widget = const GlobalNews();
        break;
      case 2:
        widget = const WeatherPage();
        break;
      default:
        widget = const GlobalNews();
        break;
    }
    return widget;
  }
}
