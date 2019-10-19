import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travel_hour/models/blog.dart';
import 'package:travel_hour/pages/blog_details.dart';
import 'package:travel_hour/variables.dart';

class ArticlesPage extends StatefulWidget {
  ArticlesPage({Key key}) : super(key: key);

  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {

  BlogData blogData = BlogData();
  List<BlogData1> _allData = [];
  
  

  PopupMenuButton _popupMenuButton = PopupMenuButton(
    child: Icon(LineIcons.sort, color: Colors.black),
    //initialValue: 'view',
    itemBuilder: (BuildContext context) {
      return <PopupMenuItem>[
        PopupMenuItem(
          child: Text('Most Viewed'),
          value: 'view',
        ),
        PopupMenuItem(
          child: Text('Most Loved'),
          value: 'loved',
        )
      ];
    },
    
    onSelected: (_value){
      print(_value);
      
    }
    
  );



  Widget cachedImage(index) {
    return CachedNetworkImage(
      imageUrl: _allData[index].picture,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          shape: BoxShape.rectangle,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => Icon(
        LineIcons.photo,
        size: 30,
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }

  _organiseData (){
    for (var i = 0; i < blogData.blogTitle.length; i++) {
      BlogData1 d = BlogData1(
        blogData.blogTitle[i], 
        blogData.blogDetails[i], 
        blogData.blogSource[i], 
        blogData.blogImage[i], 
        blogData.blogViews[i], 
        blogData.blogLoves[i]
        );

        _allData.add(d);
    }
    
    setState(() {
      //_allData.sort((a, b) => b.views.compareTo(a.views));
      
    });

    
  }


  @override
  void initState() {
    _organiseData();
    

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    //double h = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.transparent,
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Text(
            'Travel Hour Blog',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          elevation: 0.5,
          actions: <Widget>[
            _popupMenuButton,
            SizedBox(
              width: 15,
            )
          ],
        ),
        backgroundColor: Colors.grey[100],
        body: AnimationLimiter(
          child: ListView.separated(
            itemCount: _allData.length,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 0,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50,
                  child: FadeInAnimation(
                    child: Container(
                      height: 415,
                      child: InkWell(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 10, left: 15, right: 15, bottom: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.grey[300],
                                      blurRadius: 10,
                                      offset: Offset(3, 3))
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Hero(
                                  tag: 'heroArticle$index',
                                  child: Container(
                                    height: 230,
                                    width: w,
                                    child: cachedImage(index),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, left: 15, bottom: 5, right: 5),
                                  child: Text(
                                    _allData[index].title,
                                    style: textStyleBold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0, left: 15, bottom: 10, right: 10),
                                  child: Container(
                                    height: 50,
                                    child: Text(
                                      _allData[index].details,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, left: 15, right: 5, bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          LineIcons.copyright,
                                          color: Colors.blueAccent,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          _allData[index].source,
                                          style: TextStyle(
                                              color: Colors.grey[700],
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Spacer(),
                                        FlatButton.icon(
                                          padding: EdgeInsets.all(0),
                                          icon: Icon(
                                            LineIcons.heart,
                                            size: 22,
                                            color: Colors.grey,
                                          ),
                                          onPressed: () {},
                                          label: Text(
                                            _allData[index].loves.toString(),
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ArticlesDetailsPage(
                                          blogTitle: _allData[index].title,
                                          blogImage: _allData[index].picture,
                                          blogSubtitle: _allData[index].details,
                                          blogSource: _allData[index].source,
                                          blogLoves: _allData[index].loves,
                                          heroTag: 'heroArticle$index',
                                          blogIndex: index,
                                        )));
                          }),
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
