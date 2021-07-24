import 'dart:convert';

import 'package:flutter_news_api/models/article_model.dart';
import 'package:http/http.dart' as http;
class News{
  List<ArticleModel> news=[];
  Future<void>getNews() async{
    String url="https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=216d65d6e2a74dd8b75e6dc090d9bcc3";

    var response= await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null && element['title'] != null && element['url']!= null && element['content']!=null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            content: element["content"],
            url: element["url"],
          );
          news.add(articleModel);
        }
  });
}
  }
}

class CategoryNewsclass{
  List<ArticleModel> news=[];
  Future<void>getNews(String category) async{
    String url="https://newsapi.org/v2/top-headlines?category=$category&country=in&category=business&apiKey=216d65d6e2a74dd8b75e6dc090d9bcc3";

    var response= await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null && element['title'] != null && element['url']!= null && element['content']!=null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            content: element["content"],
            url: element["url"],
          );
          news.add(articleModel);
        }
      });
    }
  }
}