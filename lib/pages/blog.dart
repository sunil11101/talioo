import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:talio_travel/blocs/blog_bloc.dart';
import 'package:talio_travel/models/variables.dart';
import 'package:talio_travel/pages/blog_details.dart';
import 'package:talio_travel/widgets/blog_filter.dart';

class BlogPage extends StatelessWidget {
  BlogPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BlogBloc blogBloc =
        Provider.of<BlogBloc>(context); // to access blog data
    double w = MediaQuery.of(context).size.width;

    // this is callback function and using cached image for saving online images
    Widget cachedImage(index) {
      return CachedNetworkImage(
        imageUrl: blogBloc.allData[index].picture,
        placeholder: (context, url) => Icon(
          LineIcons.photo,
          size: 30,
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      );
    }

    return Scaffold(
      /*
        appBar: AppBar(
          
          brightness: Platform.isAndroid ? Brightness.dark : Brightness.light,
          centerTitle: false,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: TextField(
            style: TextStyle(fontSize: 15),
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.all(5.0),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, style: BorderStyle.solid),
                ),
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(LineIcons.plus_circle, size: 25),
              onPressed: () {
                //_select(choices[0]);
              },
            ),
            /*PopupMenuButton(
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
                      value: 'love',
                    )
                  ];
                },
                onSelected: (value) {
                  blogBloc.afterPopSelection(value);
                }),*/
            SizedBox(
              width: 15,
            )
          ],
        ),*/
      body: CustomScrollView(
        slivers: <Widget>[
          new SliverAppBar(
            leading: new Container(
              width: 0,
            ),
            backgroundColor: Colors.white,
            title: TextField(
              style: TextStyle(fontSize: 15),
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.all(5.0),
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.grey, style: BorderStyle.solid),
                ),
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
              ),
            ),
            actions: <Widget>[
              new IconButton(
                icon: Icon(LineIcons.plus_circle, size: 25),
                onPressed: () {
                  //_select(choices[0]);
                },
              ),
            ],
            expandedHeight: 170.0,
            floating: false,
            pinned: true,
            snap: false,
            brightness: Brightness.dark,
            flexibleSpace: BlogFilter(),
          ),
          new SliverStaggeredGrid.countBuilder(
              crossAxisCount: 4,
              staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemCount: blogBloc.allData.length,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50,
                    child: FadeInAnimation(
                      child: Card(
                        semanticContainer: false,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: InkWell(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Hero(
                                  tag: 'heroArticle$index',
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxHeight: 500, maxWidth: w),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                      ),
                                      child: cachedImage(index),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, left: 15, bottom: 5, right: 15),
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    text: TextSpan(
                                      text: blogBloc.allData[index].title,
                                      style: textStyleBold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0, left: 15, bottom: 10, right: 15),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                        minWidth: double.infinity,
                                        minHeight: 30),
                                    child: RichText(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                      text: TextSpan(
                                        text: blogBloc.allData[index].details,
                                        style: TextStyle(color: Colors.grey, fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, left: 5, bottom: 10, right: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Icon(
                                        LineIcons.copyright,
                                        size: 20,
                                        color: Colors.blueAccent,
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Flexible(
                                        child: RichText(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          text: TextSpan(
                                            text:
                                                blogBloc.allData[index].source,
                                            style: TextStyle(
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Row(
                                        children: <Widget>[
                                          Icon(LineIcons.heart,
                                              size: 20, color: Colors.grey),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            blogBloc.allData[index].loves
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              blogBloc.viewsIncrement(
                                  index); //to increse the items view amount
                              blogBloc.loveIconCheck(blogBloc.allData[index]
                                  .title); // checking user loved this item or not
                              blogBloc.bookmarkIconCheck(blogBloc.allData[index]
                                  .title); // checking user bookmarked this item or not

                              //navigating to the next screen with all this selected item's data
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BlogDetailsPage(
                                            blogTitle:
                                                blogBloc.allData[index].title,
                                            blogImage:
                                                blogBloc.allData[index].picture,
                                            blogSubtitle:
                                                blogBloc.allData[index].details,
                                            blogSource:
                                                blogBloc.allData[index].source,
                                            blogLoves:
                                                blogBloc.allData[index].loves,
                                            blogViews:
                                                blogBloc.allData[index].views,
                                            heroTag: 'heroArticle$index',
                                            blogIndex: index,
                                            blogListIndex: blogBloc
                                                .allData[index].blogListIndex,
                                          )));
                            }),
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),

      /*
        AnimationLimiter(          //used for listview animation on start
          child: StaggeredGridView.countBuilder(
            padding: const EdgeInsets.only(left: 8, right: 8),
            crossAxisCount: 4,
            staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            itemCount: blogBloc.allData.length,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50,
                  child: FadeInAnimation(
                    child: Card(
                      semanticContainer: false,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: InkWell(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Hero(
                                  tag: 'heroArticle$index',
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(maxHeight: 500, maxWidth: w),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10),),
                                      child: cachedImage(index),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, left: 15, bottom: 5, right: 15),
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    text: TextSpan(
                                      text: blogBloc.allData[index].title,
                                      style: textStyleBold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0, left: 15, bottom: 10, right: 15),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(minWidth: double.infinity, minHeight: 30),
                                    child: RichText(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                      strutStyle: StrutStyle(fontSize: 14),
                                      text: TextSpan(
                                        text:blogBloc.allData[index].details,
                                        style: TextStyle(
                                          color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, left: 5, bottom: 10, right: 5),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Icon(
                                          LineIcons.copyright,
                                          size: 20,
                                          color: Colors.blueAccent,
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Flexible(
                                          child:RichText(
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            strutStyle: StrutStyle(fontSize: 13),
                                            text: TextSpan(
                                              text: blogBloc.allData[index].source,
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Row(
                                          children: <Widget>[
                                            Icon(LineIcons.heart,
                                                size: 20, color: Colors.grey),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              blogBloc.allData[index].loves
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),

                          onTap: () {
                            blogBloc.viewsIncrement(index);   //to increse the items view amount
                            blogBloc.loveIconCheck(blogBloc.allData[index].title);  // checking user loved this item or not
                            blogBloc.bookmarkIconCheck(blogBloc.allData[index].title);  // checking user bookmarked this item or not

                            //navigating to the next screen with all this selected item's data
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlogDetailsPage(
                                          blogTitle:
                                              blogBloc.allData[index].title,
                                          blogImage:
                                              blogBloc.allData[index].picture,
                                          blogSubtitle:
                                              blogBloc.allData[index].details,
                                          blogSource:
                                              blogBloc.allData[index].source,
                                          blogLoves:
                                              blogBloc.allData[index].loves,
                                          blogViews:
                                              blogBloc.allData[index].views,
                                          heroTag: 'heroArticle$index',
                                          blogIndex: index,
                                          blogListIndex: blogBloc
                                              .allData[index].blogListIndex,
                                        )));
                          }),
                    ),
                  ),
                ),
              );
            },
          ),
        )*/
    );
  }
}
