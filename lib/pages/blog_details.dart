import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class ArticlesDetailsPage extends StatefulWidget {
  final String blogTitle,
      blogSubtitle,
      blogSource,
      blogImage,
      blogLoves,
      heroTag;
  final int blogIndex;

  ArticlesDetailsPage(
      {Key key,
      @required this.blogTitle,
      this.blogImage,
      this.blogLoves,
      this.blogSource,
      this.blogSubtitle,
      this.heroTag,
      this.blogIndex})
      : super(key: key);

  _ArticlesDetailsPageState createState() => _ArticlesDetailsPageState(
      this.blogTitle,
      this.blogImage,
      this.blogLoves,
      this.blogSource,
      this.blogSubtitle,
      this.heroTag,
      this.blogIndex);
}

class _ArticlesDetailsPageState extends State<ArticlesDetailsPage> {
  String blogTitle, blogSubtitle, blogSource, blogImage, blogLoves, heroTag;
  int blogIndex;
  _ArticlesDetailsPageState(this.blogTitle, this.blogImage, this.blogLoves,
      this.blogSource, this.blogSubtitle, this.heroTag, this.blogIndex);

  Icon loveIcon = Icon(
    Icons.favorite_border,
    color: Colors.grey,
  );
  Icon loveIconNormal = Icon(
    Icons.favorite_border,
    color: Colors.grey,
  );
  Icon loveIconBold = Icon(
    Icons.favorite,
    color: Colors.pinkAccent,
  );
  int loveAmount;
  int viewsAmount;

  Icon bookmarkIcon = Icon(
    Icons.bookmark_border,
    color: Colors.grey,
  );
  Icon bookmarkIconNormal = Icon(
    Icons.bookmark_border,
    color: Colors.grey,
  );
  Icon bookmarkIconBold = Icon(
    Icons.bookmark,
    color: Colors.grey[700],
  );

  List<String> blogList = [];

  _viewsCheck() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    int views = sp.getInt('$blogTitle/views') ?? 10000;
    int _viewsAmount = (views + (1));
    sp.setInt('$blogTitle/views', _viewsAmount);
    setState(() {
      viewsAmount = _viewsAmount;
    });
  }

  _loveIconCheck() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String uid = sp.getString('uid') ?? 'uid';
    bool checked = sp.getBool('$uid/$blogTitle/love') ?? false;
    int _loveAmount = sp.getInt('$uid/$blogTitle/loveAmount') ?? 10;
    if (checked == false) {
      setState(() {
        loveIcon = loveIconNormal;
        loveAmount = _loveAmount;
      });
    } else {
      setState(() {
        loveIcon = loveIconBold;
        loveAmount = _loveAmount;
      });
    }
  }

  _loveIconClicked() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String uid = sp.getString('uid') ?? 'uid';

    bool clicked = sp.getBool('$uid/$blogTitle/love') ?? false;
    int _loveAmount = sp.getInt('$uid/$blogTitle/loveAmount') ?? 10;
    if (clicked == false) {
      sp.setBool('$uid/$blogTitle/love', true);
      int count = (_loveAmount + (1));
      setState(() {
        loveIcon = loveIconBold;
        sp.setInt('$uid/$blogTitle/loveAmount', count);
        loveAmount = count;
      });
    } else {
      sp.setBool('$uid/$blogTitle/love', false);
      int count = (_loveAmount - (1));
      setState(() {
        loveIcon = loveIconNormal;
        sp.setInt('$uid/$blogTitle/loveAmount', count);
        loveAmount = count;
      });
    }
  }

  _bookmarkIconCheck() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String uid = sp.getString('uid') ?? 'uid';

    bool checked = sp.getBool('$uid/$blogTitle/bookmark') ?? false;
    List<String> _blogList = sp.getStringList('blogList') ?? [];
    setState(() {
      blogList = _blogList;
      print(blogList);
    });

    if (checked == false) {
      setState(() {
        bookmarkIcon = bookmarkIconNormal;
      });
    } else {
      setState(() {
        bookmarkIcon = bookmarkIconBold;
      });
    }
  }

  _bookmarkIconClicked(index) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String uid = sp.getString('uid') ?? 'uid';

    bool clicked = sp.getBool('$uid/$blogTitle/bookmark') ?? false;

    if (clicked == false) {
      sp.setBool('$uid/$blogTitle/bookmark', true);
      Toast.show('Added to your bookmark list', context,
          duration: Toast.LENGTH_LONG, backgroundColor: Colors.grey[800]);
      setState(() {
        bookmarkIcon = bookmarkIconBold;
      });
      blogList.add(index.toString());
      sp.setStringList('blogList', blogList);
      print(blogList);
    } else {
      sp.setBool('$uid/$blogTitle/bookmark', false);

      setState(() {
        bookmarkIcon = bookmarkIconNormal;
      });
      blogList.remove(index.toString());
      sp.setStringList('blogList', blogList);
      print(blogList);
    }
  }

  @override
  void initState() {
    _viewsCheck();
    _loveIconCheck();
    _bookmarkIconCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        onPressed: () {},
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
                            icon: loveIcon,
                            onPressed: () {
                              _loveIconClicked();
                            },
                          ),
                          IconButton(
                            icon: bookmarkIcon,
                            onPressed: () {
                              _bookmarkIconClicked(blogIndex);
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
                          'Views: $viewsAmount',
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
                          'Loves: $loveAmount',
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
                    '$blogSubtitle',
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
