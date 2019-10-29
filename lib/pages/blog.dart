import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:travel_hour/blocs/blog_bloc.dart';
import 'package:travel_hour/models/variables.dart';
import 'package:travel_hour/pages/blog_details.dart';


class BlogPage extends StatelessWidget {
  BlogPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BlogBloc blogBloc = Provider.of<BlogBloc>(context);

    double w = MediaQuery.of(context).size.width;

    Widget cachedImage(index) {
      return CachedNetworkImage(
        imageUrl: blogBloc.allData[index].picture,
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

    return Scaffold(
        appBar: AppBar(
          
          brightness: Platform.isAndroid ? Brightness.dark : Brightness.light,
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Text(
            'Travel Hour Blog',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          elevation: 0,
          actions: <Widget>[
            PopupMenuButton(
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
                }),
            SizedBox(
              width: 15,
            )
          ],
        ),
        
        body: AnimationLimiter(
          child: ListView.separated(
            itemCount: blogBloc.allData.length,
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
                                    blogBloc.allData[index].title,
                                    style: textStyleBold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0, left: 15, bottom: 10, right: 10),
                                  child: Container(
                                    height: 50,
                                    child: Text(
                                      blogBloc.allData[index].details,
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
                                          blogBloc.allData[index].source,
                                          style: TextStyle(
                                              color: Colors.grey[700],
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Spacer(),
                                        Row(
                                          children: <Widget>[
                                            Icon(LineIcons.heart,
                                                size: 22, color: Colors.grey),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              blogBloc.allData[index].loves
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 15,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            blogBloc.viewsIncrement(index);
                            blogBloc
                                .loveIconCheck(blogBloc.allData[index].title);
                            blogBloc.bookmarkIconCheck(
                                blogBloc.allData[index].title);
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
        ));
  }
}
