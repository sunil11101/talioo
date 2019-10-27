import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import 'package:travel_hour/blocs/blog_bloc.dart';



class ArticlesDetailsPage extends StatelessWidget {
  final String blogTitle,
      blogSubtitle,
      blogSource,
      blogImage,
      heroTag;

  final int blogLoves, blogViews, blogIndex, blogListIndex;

  ArticlesDetailsPage(
      {Key key,
      @required this.blogTitle,
      this.blogImage,
      this.blogLoves,
      this.blogViews,
      this.blogSource,
      this.blogSubtitle,
      this.heroTag,
      this.blogIndex,
      this.blogListIndex
      })
      : super(key: key);

  


 
  @override
  Widget build(BuildContext context) {
    final BlogBloc blogBloc = Provider.of<BlogBloc>(context);
    // Provider.of<BlogBloc>(context, listen: false).loveIconCheck(blogTitle);
    // Provider.of<BlogBloc>(context, listen: false).bookmarkIconCheck(blogTitle);

    
    double w = MediaQuery.of(context).size.width;
    //double h = MediaQuery.of(context).size.height;

    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 15, right: 10),
                  height: 56,
                  width: w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(0),
                        icon: Icon(LineIcons.long_arrow_left),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          size: 22,
                        ),
                        onPressed: () {
                          Share.share('Install Travel Hour App now! https://example.com');
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 10, top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Travel Hour Blog'),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        blogTitle,
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          FlatButton.icon(
                            padding: EdgeInsets.all(0),
                            icon: Icon(
                              LineIcons.copyright,
                              size: 20,
                              color: Colors.indigoAccent,
                            ),
                            label: Text(
                              blogSource,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            onPressed: () {},
                          ),
                          Spacer(),
                          IconButton(
                            icon: blogBloc.loveIcon,
                            onPressed: () {
                              blogBloc.loveIconClicked(blogIndex, blogTitle);
                            },
                          ),
                          IconButton(
                            icon: blogBloc.bookmarkIcon,
                            onPressed: () {
                              blogBloc.bookmarkIconClicked(blogIndex, blogTitle, context);
                              blogBloc.getBookmarkedBlogList();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Hero(
                  tag: heroTag,
                  child: Container(
                      height: 250,
                      width: w,
                      child: CachedNetworkImage(
                        imageUrl: blogImage,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 10),
                  child: Row(
                    children: <Widget>[
                      FlatButton.icon(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          LineIcons.eye,
                          color: Colors.grey[500],
                        ),
                        label: Text(
                          'Views: ${blogBloc.allData[blogIndex].views}',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                        onPressed: () {},
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      FlatButton.icon(
                        padding: EdgeInsets.all(0),
                        icon: Icon(
                          LineIcons.heart_o,
                          color: Colors.grey[500],
                        ),
                        label: Text(
                          'Loves: ${blogBloc.allData[blogIndex].loves}',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 10),
                  child: Text(
                    '$blogSubtitle \n\n$blogSubtitle',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                )
              ]),
        ),
      ),
    );
  }
}
