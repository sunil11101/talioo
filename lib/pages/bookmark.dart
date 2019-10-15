import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:travel_hour/models/blog.dart';
import 'package:travel_hour/models/places_data.dart';
import 'package:travel_hour/pages/blog_details.dart';
import 'package:travel_hour/pages/details.dart';
import 'package:travel_hour/variables.dart';


class BookmarkPage extends StatefulWidget {
  BookmarkPage({Key key}) : super(key: key);

  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  BlogData blogData = BlogData();
  List<int> blogListInt = [];
  List<int> placeListInt = [];

  _getBlogList() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> _blogList = sp.getStringList('blogList') ?? [];
    setState(() {
      //converting stringlist to intlist
      blogListInt = _blogList.map(int.parse).toList();
    });
  }

  _getPlaceList() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> _placeList = sp.getStringList('placeList') ?? [];
    setState(() {
      //converting stringlist to intlist
      placeListInt = _placeList.map(int.parse).toList();
    });
  }


  List<PlaceData1> _allData = [];
  PlaceData placeData = PlaceData();

  _getData(){
    for (var i = 0; i < placeData.placeName.length; i++) {
      PlaceData1 d = PlaceData1(
        placeData.image[i], 
        placeData.placeName[i],
        placeData.location[i], 
        placeData.loves[i], 
        placeData.views[i], 
        placeData.comments[i], 
        placeData.placeDeatails[i]
        
        );
      _allData.add(d);
    }
  }

  @override
  void initState() {
    _getPlaceList();
    _getBlogList();
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          //elevation: 1,
          automaticallyImplyLeading: false,
          title: TabBar(
            labelColor: Colors.black,
            labelStyle: TextStyle(fontWeight: FontWeight.w500),
            unselectedLabelColor: Colors.grey,
            indicatorWeight: 2,
            indicatorColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: <Widget>[
              Tab(
                text: 'SAVED PLACES',
              ),
              Tab(
                text: 'SAVED BLOGS',
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            placeListInt.isEmpty ? _emptyUI() : _placeUI(),
            blogListInt.isEmpty ? _emptyUI() : _blogUI(),
          ],
        ),
      ),
    );
  }

  Widget _emptyUI() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image(
            height: 200,
            width: 200,
            image: AssetImage('assets/empty.png'),
            fit: BoxFit.contain,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'No Saved Items',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
          )
        ],
      ),
    );
  }

  Widget _blogUI() {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView.builder(
        itemCount: blogListInt.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 15, right: 10, bottom: 5),
              child: Container(
                alignment: Alignment.center,
                height: 120,
                width: w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        topLeft: Radius.circular(15)),
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey[200],
                          blurRadius: 2,
                          offset: Offset(3, 3))
                    ]),
                child: Row(
                  children: <Widget>[
                    Hero(
                      tag: 'heroArticleFromBookmark$index',
                      child: Container(
                        height: h,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                topLeft: Radius.circular(15)),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    blogData.blogImage[blogListInt[index]]))),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 10, left: 10, right: 5, bottom: 10),
                        height: h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              blogData.blogTitle[blogListInt[index]],
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[800]),
                            ),
                            Spacer(),
                            Row(
                              children: <Widget>[
                                Icon(
                                  LineIcons.copyright,
                                  color: Colors.grey,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  blogData.blogSource[blogListInt[index]],
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ArticlesDetailsPage(
                            blogTitle: blogData.blogTitle[blogListInt[index]],
                            blogImage: blogData.blogImage[blogListInt[index]],
                            blogSubtitle:
                                blogData.blogDetails[blogListInt[index]],
                            blogSource: blogData.blogSource[blogListInt[index]],
                            blogLoves: blogData.blogLoves[blogListInt[index]],
                            heroTag: 'heroArticleFromBookmark$index',
                            blogIndex: blogListInt[index],
                          )));
            },
          );
        },
      ),
    );
  }

  Widget _placeUI() {
    double w = MediaQuery.of(context).size.width;
    //double h = MediaQuery.of(context).size.height;

    Widget cachedImage(index) {
      return CachedNetworkImage(
        imageUrl: imageList[index],
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            shape: BoxShape.rectangle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey[200], offset: Offset(5, 5), blurRadius: 2),
            ],
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

    return Scaffold(
      body: AnimationLimiter(
        child: ListView.builder(
          itemCount: placeListInt.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
                position: index,
                duration: Duration(milliseconds: 375),
                child: SlideAnimation(
                    verticalOffset: 50,
                    child: FadeInAnimation(
                        child: InkWell(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.bottomRight,
                            height: 160,
                            width: w,
                            //color: Colors.cyan,
                            child: Stack(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    height: 120,
                                    width: w * 0.87,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          color: Colors.grey[200],
                                          blurRadius: 2,
                                          offset: Offset(5, 5),
                                        )
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 110),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            _allData[placeListInt[index]].name,
                                            style: textStyleBold,
                                          ),
                                          Text(
                                            _allData[placeListInt[index]].location,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[500],
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Divider(
                                            color: Colors.grey[400],
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Icon(
                                                LineIcons.heart,
                                                size: 18,
                                                color: Colors.orangeAccent,
                                              ),
                                              Text(
                                                ' 20',
                                                style: textStylicon,
                                              ),
                                              Spacer(),
                                              Icon(
                                                LineIcons.eye,
                                                size: 18,
                                                color: Colors.grey,
                                              ),
                                              Text(
                                                ' 2000',
                                                style: textStylicon,
                                              ),
                                              Spacer(),
                                              Icon(
                                                LineIcons.comment_o,
                                                size: 18,
                                                color: Colors.grey,
                                              ),
                                              Text(
                                                ' 24',
                                                style: textStylicon,
                                              ),
                                              Spacer(),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                              bottom: 25,
                              left: 12,
                              child: Hero(
                                tag: 'heroPlaceBookmark$index',
                                child: Container(
                                  height: 120,
                                  width: 120,
                                  child: cachedImage(placeListInt[index]),
                                ),
                              ))
                        ],
                      ),
                      onTap: () {
                        print('heroPlaceBookmark$index');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                      placeName: _allData[placeListInt[index]].name,
                                      placeLocation: _allData[placeListInt[index]].location,
                                      loves: _allData[placeListInt[index]].loves.toString(),
                                      views: _allData[placeListInt[index]].views.toString(),
                                      comments: _allData[placeListInt[index]].comments.toString(),
                                      picturesList: imageList,
                                      placeDetails: _allData[placeListInt[index]].details,
                                      heroTag: 'heroPlaceBookmark$index',
                                      placeIndex: index,
                                    )));
                      },
                    ))));
          },
        ),
      ),
    );
  }
}
