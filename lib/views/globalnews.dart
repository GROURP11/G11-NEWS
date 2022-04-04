import 'package:flutter/material.dart';
import 'package:news1/helper/data.dart';
import 'package:news1/model/article_model.dart';
import 'package:news1/model/category_model.dart';
import 'package:news1/helper/news.dart';
import 'package:news1/views/article_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GlobalNews extends StatefulWidget {
  const GlobalNews({Key? key}) : super(key: key);

  @override
  State<GlobalNews> createState() => _GlobalNewsState();
}

class _GlobalNewsState extends State<GlobalNews> {
  /* Category list */
  List<CategoryModel> categories =
      new List<CategoryModel>.empty(growable: true);
  /* articles list */
  List<ArticleModel> articles = new List<ArticleModel>.empty(growable: true);

  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: <Widget>[
            /* NEW CATEGORIES */
            Container(
              //padding: EdgeInsets.symmetric(horizontal: 16),
              height: 70,
              child: ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CategoryTile(
                      imageUrl: categories[index].imageUrl,
                      categoryName: categories[index].categoryName,
                    );
                  }),
            ),
            /* CIRCULAR PROGRESS INDICATOR */
            _loading
                ? Center(
                    child: Container(
                      child: CircularProgressIndicator(),
                    ),
                  )
                /* NEWS BLOCKS */
                : Container(
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(top: 16),
                        itemCount: articles.length,
                        shrinkWrap: true,
                        //physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return BlogTile(
                              imageUrl: articles[index].urlToImage,
                              title: articles[index].title,
                              desc: articles[index].description,
                              url: articles[index].url);
                        }),
                  )
          ],
        ),
      ),
    );
  }
}

// cards for categories

class CategoryTile extends StatelessWidget {
  //const CategoryTile({ Key? key }) : super(key: key);

  final imageUrl, categoryName;
  CategoryTile({this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // onclick function
      },
      child: Container(
        margin: EdgeInsets.only(right: 3),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 120,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(
                categoryName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// block tile
class BlogTile extends StatelessWidget {
  //const BlogTile({Key? key}) : super(key: key);
  final String? imageUrl, title, desc, url;
  BlogTile(
      {@required this.imageUrl,
      @required this.title,
      @required this.desc,
      @required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      imageUrl: url,
                    )));
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 16),
          child: Column(
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(imageUrl!)),
              SizedBox(
                height: 8,
              ),
              Text(
                title!,
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                desc!,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )),
    );
  }
}
