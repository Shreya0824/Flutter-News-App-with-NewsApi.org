import 'package:flutter/material.dart';
import 'package:flutter_news_api/helper/news.dart';
import 'package:flutter_news_api/models/article_model.dart';
import 'home.dart';

class CategoryNews extends StatefulWidget {
final String category;
CategoryNews({required this.category});
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles=[];
  bool _loading=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }
  getCategoryNews()async{
    CategoryNewsclass newsclass=CategoryNewsclass();
    await newsclass.getNews(widget.category);
    articles=newsclass.news;
    setState(() {
      _loading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget> [
            Text("Flutter"),
            Padding(
                padding: EdgeInsets.only(right: 65),
                child: Text("News",style: TextStyle(color: Colors.blue),))
          ],
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 16),
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: articles.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context,index){
                return BlogTile(url: articles[index].url,imageUrl: articles[index].urlToImage, desc: articles[index].description, title: articles[index].title);
              }
          ),),
      )

    );
  }
}
