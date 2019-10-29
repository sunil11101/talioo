import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import 'package:travel_hour/blocs/blog_bloc.dart';
import 'package:travel_hour/blocs/places_bloc.dart';

import 'package:travel_hour/models/blog.dart';
import 'package:travel_hour/models/places_data.dart';

import 'package:travel_hour/pages/details.dart';
import 'package:travel_hour/pages/blog_details.dart';

import 'package:travel_hour/models/variables.dart';





class BookmarkPage extends StatefulWidget {
  BookmarkPage({Key key}) : super(key: key);

  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {


  @override
  void initState() { 
    super.initState();
    BlogBloc().getBookmarkedBlogList();
    PlacesBloc().getBookmarkedPlaceList();
  }


  @override
  Widget build(BuildContext context) {


    

    final BlogBloc blogBloc = Provider.of<BlogBloc>(context);
    final PlacesBloc placesBloc = Provider.of<PlacesBloc>(context);
    // Provider.of<BlogBloc>(context, listen: false).getBookmarkedBlogList();
    // Provider.of<PlacesBloc>(context, listen: false).getBookmarkedPlaceList();

    

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          brightness: Platform.isAndroid ? Brightness.dark : Brightness.light,
          
          automaticallyImplyLeading: false,
          title: Container(
            height: 60,
            child: TabBar(
              labelColor: Colors.grey[800],
              labelStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'Raleway',
                fontSize: 15
                
                ),
              unselectedLabelColor: Colors.grey[400],
              indicatorWeight: 2,
              indicatorColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: <Widget>[
                Tab(
                  child: Text('SAVED PLACES', ),

                ),
                Tab(
                  child: Text('SAVED BLOGS', ),
                )
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            placesBloc.placeListInt.isEmpty ? _emptyUI(w,h) : _placeUI(w,h, context, placesBloc),
            blogBloc.blogListInt.isEmpty ? _emptyUI(w,h) : _blogUI(w,h, context, blogBloc),
          ],
        ),
      ),
    );
  }

  Widget _emptyUI(w,h) {
    return Container(
      
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image(
            height: 200,
            width: 200,
            image: AssetImage('assets/images/empty.png'),
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

  Widget _blogUI(w,h, context, blogBloc) {
    BlogData blogData = BlogData();
    
    //final BlogBloc blogBloc = Provider.of<BlogBloc>(context);
    
    
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: blogBloc.blogListInt.length,
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
                            color: Colors.grey[300],
                            blurRadius: 2,
                            offset: Offset(2, 2))
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
                                  image: CachedNetworkImageProvider(blogData.blogImage[blogBloc.blogListInt[index]])
                                  )),
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
                                blogData.blogTitle[blogBloc.blogListInt[index]],
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
                                    blogData.blogSource[blogBloc.blogListInt[index]],
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
                blogBloc.viewsIncrement(blogBloc.blogListInt[index]);
                blogBloc.loveIconCheck(blogData.blogTitle[blogBloc.blogListInt[index]]);
                blogBloc.bookmarkIconCheck(blogData.blogTitle[blogBloc.blogListInt[index]]);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlogDetailsPage(
                              blogTitle: blogData.blogTitle[blogBloc.blogListInt[index]],
                              blogImage: blogData.blogImage[blogBloc.blogListInt[index]],
                              blogSubtitle:
                                  blogData.blogDetails[blogBloc.blogListInt[index]],
                              blogSource: blogData.blogSource[blogBloc.blogListInt[index]],
                              blogLoves: blogData.blogLoves[blogBloc.blogListInt[index]],
                              blogViews: blogData.blogViews[blogBloc.blogListInt[index]],
                              heroTag: 'heroArticleFromBookmark$index',
                              blogIndex: blogBloc.blogListInt[index],
                              blogListIndex: 1,

                            )));
              },
            );
          },
        ),
      ),
    );
  }

  Widget _placeUI(w,h, context, placesBloc) {
    
    PlaceData placeData = PlaceData();
    
    

    double w = MediaQuery.of(context).size.width;
    //double h = MediaQuery.of(context).size.height;

    Widget cachedImage(index) {
      return CachedNetworkImage(
        imageUrl: placeData.image[index],
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
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: ListView.builder(
            itemCount: placesBloc.placeListInt.length,
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
                                              placesBloc.allData[placesBloc.placeListInt[index]].name,
                                              style: textStyleBold,
                                            ),
                                            Text(
                                              placesBloc.allData[placesBloc.placeListInt[index]].location,
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
                                                  ' ${placesBloc.allData[placesBloc.placeListInt[index]].loves}',
                                                  style: textStylicon,
                                                ),
                                                Spacer(),
                                                Icon(
                                                  LineIcons.eye,
                                                  size: 18,
                                                  color: Colors.grey,
                                                ),
                                                Text(
                                                  ' ${placesBloc.allData[placesBloc.placeListInt[index]].views}',
                                                  style: textStylicon,
                                                ),
                                                Spacer(),
                                                Icon(
                                                  LineIcons.comment_o,
                                                  size: 18,
                                                  color: Colors.grey,
                                                ),
                                                Text(
                                                  ' ${placesBloc.allData[placesBloc.placeListInt[index]].comments}',
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
                                    child: cachedImage(placesBloc.placeListInt[index]),
                                  ),
                                ))
                          ],
                        ),
                        onTap: () {
                          
                          placesBloc.viewsIncrement(placesBloc.placeListInt[index]); 
                          placesBloc.loveIconCheck(placeData.placeName[placesBloc.placeListInt[index]]);
                          placesBloc.bookmarkIconCheck(placeData.placeName[placesBloc.placeListInt[index]]);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsPage(
                                    
                                        placeName: placeData.placeName[placesBloc.placeListInt[index]],   
                                        placeLocation: placeData.location[placesBloc.placeListInt[index]],
                                        loves: placeData.loves[placesBloc.placeListInt[index]],
                                        views: placeData.views[placesBloc.placeListInt[index]],
                                        comments: placeData.comments[placesBloc.placeListInt[index]],
                                        picturesList: placeData.imageList[placesBloc.placeListInt[index]],
                                        placeDetails: placeData.placeDeatails[placesBloc.placeListInt[index]],
                                        heroTag: 'heroPlaceBookmark$index',
                                        placeIndex: placesBloc.placeListInt[index],
                                        
                                      )));
                        },
                      ))));
            },
          ),
        ),
      ),
    );
  }
}
