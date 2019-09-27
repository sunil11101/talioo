import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:travel_hour/comments.dart';
import 'package:travel_hour/data_list.dart';
import 'package:travel_hour/map.dart';
import 'package:travel_hour/placelist.dart';
import 'package:travel_hour/travel_guide.dart';

class MyData {
  List<String> listbook;
}

class DetailsPage extends StatefulWidget {
  final String placeName, placeLocation, loves, views, comments, placeDetails,heroTag;
  final List picturesList;

  DetailsPage(
      {Key key,
      @required 
      this.placeName,
      this.placeLocation,
      this.loves,
      this.views,
      this.comments,
      this.placeDetails,
      this.heroTag,
      this.picturesList
      })
      : super(key: key);

  _DetailsPageState createState() => _DetailsPageState(
  
      this.placeName,
      this.placeLocation,
      this.loves,
      this.views,
      this.comments,
      this.placeDetails,
      this.heroTag,
      this.picturesList);
}

class _DetailsPageState extends State<DetailsPage> {
  String placeName, placeLocation, loves, views, comments, placeDetails,heroTag;
  List picturesList;
  _DetailsPageState(this.placeName,
      this.placeLocation,
      this.loves,
      this.views,
      this.comments,
      this.placeDetails,
      this.heroTag,
      this.picturesList);

  Icon loveIcon = Icon(Icons.favorite_border,color: Colors.grey,);
  Icon loveIconNormal = Icon(Icons.favorite_border,color: Colors.grey,);
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

  _viewsCheck() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    int views = sp.getInt('$placeName/views') ?? 10000;
    int _viewsAmount = (views + (1));
    sp.setInt('$placeName/views', _viewsAmount);
    setState(() {
      viewsAmount = _viewsAmount;
    });
  }

  _loveIconCheck() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String uid = sp.getString('uid') ?? 'uid';
    bool checked = sp.getBool('$uid/$placeName/love') ?? false;
    int _loveAmount = sp.getInt('$uid/$placeName/loveAmount') ?? 10;
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

    bool clicked = sp.getBool('$uid/$placeName/love') ?? false;
    int _loveAmount = sp.getInt('$uid/$placeName/loveAmount') ?? 10;
    if (clicked == false) {
      sp.setBool('$uid/$placeName/love', true);
      int count = (_loveAmount + (1));
      setState(() {
        loveIcon = loveIconBold;
        sp.setInt('$uid/$placeName/loveAmount', count);
        loveAmount = count;
      });
    } else {
      sp.setBool('$uid/$placeName/love', false);
      int count = (_loveAmount - (1));
      setState(() {
        loveIcon = loveIconNormal;
        sp.setInt('$uid/$placeName/loveAmount', count);
        loveAmount = count;
      });
    }
  }

  _bookmarkIconCheck() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String uid = sp.getString('uid') ?? 'uid';

    bool checked = sp.getBool('$uid/$placeName/bookmark') ?? false;

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

  _bookmarkIconClicked() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String uid = sp.getString('uid') ?? 'uid';

    bool clicked = sp.getBool('$uid/$placeName/bookmark') ?? false;

    if (clicked == false) {
      sp.setBool('$uid/$placeName/bookmark', true);
      Toast.show('Added to your bookmark list', context,
        duration: Toast.LENGTH_LONG,
        backgroundColor: Colors.grey
      );
      setState(() {
        bookmarkIcon = bookmarkIconBold;
      });
    } else {
      sp.setBool('$uid/$placeName/bookmark', false);

      setState(() {
        bookmarkIcon = bookmarkIconNormal;
      });
    }
  }

  @override
  void initState() {
    
    print(heroTag);
    _viewsCheck();
    _loveIconCheck();
    _bookmarkIconCheck();
    super.initState();
  }

  Widget cachedImage(index) {
    return CachedNetworkImage(
      imageUrl: imageList[index],
      imageBuilder: (context, imageProvider) => Container(
        height: 280,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          shape: BoxShape.rectangle,
          // boxShadow: <BoxShadow>[
          //   BoxShadow(
          //       color: Colors.grey[200], offset: Offset(5, 5), blurRadius: 2),
          // ],
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

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              
              children: <Widget>[
                Hero(
                  tag: heroTag,
                    child: Container(
                      color: Colors.white,
                      child: Container(
                      height: h * 0.45,
                      width: w,
                      decoration: BoxDecoration(
                        
                        // boxShadow: <BoxShadow>[
                        //   BoxShadow(
                        //       color: Colors.grey[300],
                        //       blurRadius: 50,
                        //       offset: Offset(5, 5))
                        // ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                      ),
                      child: Carousel(
                        dotBgColor: Colors.transparent,
                        showIndicator: true,
                        dotSize: 5,
                        boxFit: BoxFit.cover,
                        images: [
                          cachedImage(0),
                          cachedImage(1),
                          cachedImage(2),
                          cachedImage(3),
                          cachedImage(4)
                        ],
                      ),
                  ),
                    ),
                ),
                Positioned(
                  top: 50,
                  left: 15,
                  child: CircleAvatar(
                    backgroundColor: Colors.blue.withOpacity(0.9),
                    child: IconButton(
                      icon: Icon(
                        LineIcons.arrow_left,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),

            Container(
              padding: EdgeInsets.only(top: 15, bottom: 20),
              height: 145,
              width: w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      

                      ),
                      
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey[200],
                        blurRadius: 20,
                        offset: Offset.zero
              )]
              
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 35,
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.location_on, color: Colors.grey, size: 16),
                          Text(
                            '$placeLocation',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          IconButton(
                            icon: loveIcon,
                            iconSize: 28,
                            onPressed: () {
                              _loveIconClicked();
                            },
                          ),
                          
                          IconButton(
                            icon: bookmarkIcon,
                            iconSize: 28,
                            onPressed: () {
                              _bookmarkIconClicked();
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 25,
                      child: Row(
                        children: <Widget>[
                          Text(
                            ' $placeName',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w800,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 15,
                      endIndent: 15,
                      color: Colors.grey[400],
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: w * 0.80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              LineIcons.eye,
                              size: 20,
                              color: Colors.grey,
                            ),
                            Text(' $viewsAmount',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey)),
                            SizedBox(
                              width: 40,
                            ),
                            Icon(
                              LineIcons.heart,
                              size: 20,
                              color: Colors.grey,
                            ),
                            Text(' $loveAmount',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey)),
                            SizedBox(
                              width: 40,
                            ),
                            Icon(
                              LineIcons.comment_o,
                              size: 20,
                              color: Colors.grey,
                            ),
                            Text(' $comments',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 15, right: 10, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'About This Place',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '$placeDetails',textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),

            //To  do

            TodoWidgets(),

            // Other Places

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 30,
                width: w,
                child: Row(
                  children: <Widget>[
                    Text(
                      'Other Places',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                    InkWell(
                      child: Text(
                        'View All >',
                        style: TextStyle(fontSize: 13),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlaceListPage(
                                      title: 'Other Places',
                                    )));
                      },
                    )
                  ],
                ),
              ),
            ),

            new OtherPlaces(w: w),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}

class OtherPlaces extends StatelessWidget {
  const OtherPlaces({
    Key key,
    @required this.w,
  }) : super(key: key);

  final double w;

  @override
  Widget build(BuildContext context) {
     Widget cachedImage(index) {
    return CachedNetworkImage(
      imageUrl: imageList[index],
      imageBuilder: (context, imageProvider) => Container(
        height: 280,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          shape: BoxShape.rectangle,
          // boxShadow: <BoxShadow>[
          //   BoxShadow(
          //       color: Colors.grey[200], offset: Offset(5, 5), blurRadius: 2),
          // ],
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
    return Container(
              height: 205,
              width: w,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: placeNameList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: InkWell(
                      child: Stack(
                        children: <Widget>[
                          Hero(
                            tag: 'heroOtherPlaces $index',
                                                      child: Container(
                              height: 200,
                              width: w * 0.35,
                              child: cachedImage(index),

                              
                            ),
                          ),
                          Positioned(
                            right: 10,
                            top: 15,
                            height: 35,
                            width: 80,
                            child: FlatButton.icon(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(25)),),
                              color: Colors.grey[600].withOpacity(0.5),
                              icon: Icon(
                                LineIcons.heart,
                                color: Colors.white,
                                size: 20,
                              ),
                              label: Text(
                                '120',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                              onPressed: () {},
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 10,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                    width: w * 0.32,
                                    child: Text(placeNameList[index],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600))),
                                Text(locationList[index],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          )
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsPage(
                                      placeName: placeNameList[index],
                                      placeLocation: locationList[index],
                                      loves: loveList[index],
                                      views: viewList[index],
                                      comments: commentList[index],
                                      picturesList: imageList,
                                      placeDetails: placeDeatailsList[index],
                                      heroTag: 'heroOtherPlaces$index',
                                    )));
                      },
                    ),
                  );
                },
              ),
            );
  }
}

class TodoWidgets extends StatelessWidget {
  const TodoWidgets({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'To Do',
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: 0,
          ),
          Container(
            height: 320,
            //width: w,
            child: GridView.count(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: 1.4,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                InkWell(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey[200],
                                  offset: Offset(5, 5),
                                  blurRadius: 2)
                            ]),
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.blueAccent[400],
                                    offset: Offset(5, 5),
                                    blurRadius: 2)
                              ]),
                          child: Icon(
                            LineIcons.hand_o_left,
                            size: 30,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 15,
                        left: 15,
                        child: Text(
                          'Travel Guide',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    showModalBottomSheet(
                        elevation: 0,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        context: context,
                        builder: (BuildContext bc) {
                          return TravelGuide();
                        });
                  },
                ),
                InkWell(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey[200],
                                  offset: Offset(5, 5),
                                  blurRadius: 2)
                            ]),
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.orangeAccent[400],
                                    offset: Offset(5, 5),
                                    blurRadius: 2)
                              ]),
                          child: Icon(
                            LineIcons.hotel,
                            size: 30,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 15,
                        left: 15,
                        child: Text(
                          'Nearby Hotels',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    showModalBottomSheet(
                        elevation: 0,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        context: context,
                        builder: (BuildContext bc) {
                          return TravelGuide();
                        });
                  },
                ),
                InkWell(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.pinkAccent,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey[200],
                                  offset: Offset(5, 5),
                                  blurRadius: 2)
                            ]),
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.pinkAccent[400],
                                    offset: Offset(5, 5),
                                    blurRadius: 2)
                              ]),
                          child: Icon(Icons.restaurant),
                        ),
                      ),
                      Positioned(
                        bottom: 15,
                        left: 15,
                        child: Text(
                          'Nearby Restaurents',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    showModalBottomSheet(
                        elevation: 0,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        context: context,
                        builder: (BuildContext bc) {
                          return MapTest();
                        });
                  },
                ),
                InkWell(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.indigoAccent,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey[200],
                                  offset: Offset(5, 5),
                                  blurRadius: 2)
                            ]),
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.indigoAccent[400],
                                    offset: Offset(5, 5),
                                    blurRadius: 2)
                              ]),
                          child: Icon(
                            LineIcons.comments,
                            size: 30,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 15,
                        left: 15,
                        child: Text(
                          'User Reviews',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    showModalBottomSheet(
                        elevation: 0,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        context: context,
                        builder: (BuildContext bc) {
                          return CommentsPage();
                        });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
