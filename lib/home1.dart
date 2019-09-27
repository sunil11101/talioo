import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_hour/account.dart';
import 'package:travel_hour/details.dart';
import 'package:travel_hour/placelist.dart';
import 'package:travel_hour/placelist1.dart';
import 'package:travel_hour/data_list.dart';
import 'package:travel_hour/variables.dart';
import 'package:cached_network_image/cached_network_image.dart';



class HomePage1 extends StatefulWidget {
  HomePage1({Key key}) : super(key: key);

  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  List placesByLocation = [
    'Dhaka',
    'Chittagong',
    'Sylhet',
    'Rajshahi',
    'Khulna',
    'Barisal',
    'Rangpur',
    'Mymensingh'
  ];

  String userName, userEmail; 
  
  String userProfilePic = '';
  int listIndex = 0;

  Future _getUserDetailsfromSP() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var name = sharedPreferences.getString('userName')?? 'name';
    var email = sharedPreferences.getString('userEmail')?? 'email';
    var pic = sharedPreferences.getString('userProfilePic')?? 'pic';
    setState(() {
      this.userName = name;
      this.userEmail = email;
      this.userProfilePic = pic;
    });
    print(userName);
    
  }

  @override
  void initState() {
    _getUserDetailsfromSP();
   
    super.initState();
  }

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

  Widget searchBar(w) {
    return Padding(
        padding: const EdgeInsets.only(top: 0, left: 15, right: 10, bottom: 5),
        child: InkWell(
          child: Container(
              alignment: Alignment.centerLeft,
              height: 45,
              width: w,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey[400], width: 0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Icon(CupertinoIcons.search),
                    SizedBox(
                      width: 20,
                    ),
                    Text('Search Places & Explore'),
                  ],
                ),
              ),
            
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PlaceListPage1()));
          },
        ),
      
    );
  }

  Widget featured(w) {
    return Container(
      height: 305,
      width: w,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: placeNameList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: const EdgeInsets.only(left: 15),
              child: SizedBox(
                  height: 300,
                  width: w * 0.80,
                  child: InkWell(
                    child: Stack(
                      children: <Widget>[
                        Hero(
                          tag: 'heroFeatured$index',
                            child: Container(
                            height: 250,
                            width: w * 0.80,

                            child: cachedImage(index),

                           
                          ),
                        ),
                        Positioned(
                          height: 120,
                          width: w * 0.70,
                          left: 20,
                          bottom: 15,
                          child: Container(
                            //margin: EdgeInsets.all(0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.grey[200],
                                      offset: Offset(0, 2),
                                      blurRadius: 2)
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    ' ${placeNameList[index]}',
                                    style: textStyleBold,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.location_on,
                                        size: 14,
                                        color: Colors.grey,
                                      ),
                                      Text(locationList[index],style: TextStyle(
                                        fontSize: 12,fontWeight: FontWeight.w500,color: Colors.grey[500]))
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.grey[300],
                                    height: 20,
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(
                                          LineIcons.heart,
                                          size: 18,
                                          color: Colors.orange,
                                        ),
                                        Text(
                                          ' ${loveList[index]}',
                                          style: textStylicon,
                                        ),
                                        Spacer(),
                                        Icon(
                                          LineIcons.eye,
                                          size: 18,
                                          color: Colors.orange,
                                        ),
                                        Text(
                                          ' ${viewList[index]}',
                                          style: textStylicon,
                                        ),
                                        Spacer(),
                                        Icon(
                                          LineIcons.comment_o,
                                          size: 18,
                                          color: Colors.orange,
                                        ),
                                        Text(
                                          ' ${commentList[index]}',
                                          style: textStylicon,
                                        ),
                                        Spacer(),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        
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
                                    heroTag: 'heroFeatured$index',
                                  )));
                    },
                  ),
                ),
              
            
          );
        },
      ),
    );
  }

  Widget header (w) {
    return Padding(
                padding: const EdgeInsets.only(
                    top: 50, left: 20, right: 10, bottom: 20),
                child: SizedBox(
                  height: 55,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Travel Hour',
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.w700,color: Colors.black),
                          ),
                          Text(
                            ' Explore Bangladesh',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600]),
                          )
                        ],
                      ),
                      Spacer(),
                      InkWell(
                        child: userProfilePic.isEmpty 
                        
                        ? Container(height: 50,width: 50,
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              shape: BoxShape.circle,
                              
                              ),
                              child: Icon(Icons.person,size: 28),
                        )
                        
                        : Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      userProfilePic),
                                  fit: BoxFit.contain)),
                        ),
                        onTap: () {
                          showModalBottomSheet(
                              elevation: 0,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              context: context,
                              builder: (BuildContext bc) {
                                return AccountPage();
                              });
                        },
                      )
                    ],
                  ),
                ));
  }

  Widget popularPlaces (w){
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
                            tag: 'heroPopular$index',
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
                                      heroTag: 'heroPopular$index',
                                    )));
                      },
                    ),
                  );
                },
              ),
            );
  }

  Widget placesNearYou (w){
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
                            tag: 'heroPlacesNearYou$index',
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
                                      heroTag: 'heroPlacesNearYou$index',
                                    )));
                      },
                    ),
                  );
                },
              ),
            );
  }

  Widget placesBylocation (w) {
    return Container(
              height: 900,
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                itemCount: placesByLocation.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 15, right: 10),
                    child: Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: w * 0.92,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey[200],
                                offset: Offset(5, 5),
                                blurRadius: 1)
                          ]),
                      child: ListTile(
                        leading: CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            child: Icon(LineIcons.location_arrow, size: 25,color: Colors.white,)),
                        title: Text(
                          placesByLocation[index],
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          '212 Places',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        trailing: IconButton(
                          icon: Icon(LineIcons.arrow_right,color: Colors.blueAccent,),
                          onPressed: () {},
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PlaceListPage(
                                        title: placesByLocation[index],
                                      )));
                        },
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 10,
                  );
                },
              ),
            );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      //backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: AnimationLimiter(
          child: Column(
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 400),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: <Widget>[
                header(w),

            searchBar(w),

            SizedBox(
              height: 15,
            ),

            

            featured(w),

            DotsIndicator(
              dotsCount: placeNameList.length,
              position: 2,
              decorator: DotsDecorator(
                size: const Size.square(8.0),
                activeSize: const Size(16.0, 8.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),

            

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 30,
                width: w,
                child: Row(
                  children: <Widget>[
                    Text(
                      'Popular Places',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                    InkWell(
                      child: Text(
                        'View All >',
                        style: TextStyle(fontSize: 13,color: Colors.grey[500]),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlaceListPage(
                                      title: 'Popular Places',
                                    )));
                      },
                    )
                  ],
                ),
              ),
            ),

            popularPlaces(w),

           

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 30,
                width: w,
                child: Row(
                  children: <Widget>[
                    Text(
                      'Places Near You',
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
                                      title: 'Places Near You',
                                    )));
                      },
                    )
                  ],
                ),
              ),
            ),

            placesNearYou(w),

            

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 30,
                width: w,
                child: Row(
                  children: <Widget>[
                    Text(
                      'Select Places By location',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),

            placesBylocation(w),
              ],
            ),
          ),
        ),
          
          
          
          
         
        )
    );
  }
}
