import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_api/helper/data.dart';
import 'package:flutter_news_api/helper/news.dart';
import 'package:flutter_news_api/models/article_model.dart';
import 'package:flutter_news_api/models/category_model.dart';
import 'package:flutter_news_api/views/article_view.dart';
import 'package:flutter_news_api/views/category_news.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
List<CategoryModel> categories= [];
List<ArticleModel> articles=[];
bool _loading=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories=getCategories();
    getNews();
  }
  getNews()async{
    News news=News();
    await news.getNews();
    articles=news.news;
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
            Text("News",style: TextStyle(color: Colors.blue),)
          ],
        ),
        elevation: 0.0,
      ),
      body:_loading?Center(child: Container(child: CircularProgressIndicator(),)) :SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 70,
                child: ListView.builder(
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                      return CategoryTile(
                        imageUrl: categories[index].imageUrl,
                        categoryName: categories[index].categoryName,
                      );
                    }
                ),
              ),
              Container(
                margin: EdgeInsets.all(12),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                  itemCount: articles.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context,index){
                    return BlogTile(url: articles[index].url,imageUrl: articles[index].urlToImage, desc: articles[index].description, title: articles[index].title);
                  }
              ),)
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
final imageUrl,categoryName;
CategoryTile({this.imageUrl,this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryNews(category: categoryName.toString().toLowerCase(),)));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(imageUrl: imageUrl,width: 120,height: 60,fit: BoxFit.cover,)),
            Container(
              width: 120,height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                color: Colors.black26
              ),
              child: Text(categoryName,style: TextStyle(
                color: Colors.white
              ),),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl,title,desc,url;
  BlogTile({required this.imageUrl,required this.desc,required this.title,required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(
            builder: (context)=>ArticleView(
                blogUrl: url,
            )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(imageUrl)),
            SizedBox(height: 5,),
            Text(title,style: TextStyle(fontSize: 17,color: Colors.black87,fontWeight: FontWeight.w600),),
            SizedBox(height: 5,),
            Text(desc,style: TextStyle(color: Colors.black54),),
          ],
        ),
      ),
    );
  }
}
