import 'package:flutter/material.dart';
import 'package:news1/model/article_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String apiUrl =
        "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=1f77c8130fa443068745e92f33f744a0";
    var response = await http.get(Uri.parse(apiUrl));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      jsonData['articles'].forEach((element) {
        if ((element['urlToImage'] != null) &&
            (element['description'] != null)) {
          ArticleModel articleModel = ArticleModel(
              author: element['author'],
              title: element['title'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              content: element["content"]);
          news.add(articleModel);
        }
      });
    }
  }
}
