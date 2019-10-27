
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:travel_hour/models/places_data.dart';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:travel_hour/pages/account.dart';
import 'package:travel_hour/pages/placelist.dart';
import 'package:travel_hour/pages/search.dart';
import 'package:travel_hour/widgets/featured_places.dart';
import 'package:travel_hour/widgets/places_near_you.dart';
import 'package:travel_hour/widgets/placesby_location.dart';
import 'package:travel_hour/widgets/popular_places.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  


  PlaceData placeData = PlaceData();
  
  String userName, userEmail;

  String userProfilePic = '';
  int listIndex = 0;
  

  Future _getUserDetailsfromSP() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var name = sharedPreferences.getString('userName') ?? 'name';
    var email = sharedPreferences.getString('userEmail') ?? 'email';
    var pic = sharedPreferences.getString('userProfilePic') ?? 'pic';
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

  Widget searchBar(w) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 5),
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
              MaterialPageRoute(builder: (context) => SearchPage()));
        },
      ),
    );
  }

  Widget header(w) {
    return Padding(
        padding:
            Platform.isAndroid ? 
            const EdgeInsets.only(top: 50, left: 20, right: 15, bottom: 18)
            : const EdgeInsets.only(top: 70, left: 20, right: 10, bottom: 20),
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
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  Text(
                    ' Explore Bangladesh',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600]),
                  )
                ],
              ),
              Spacer(),
              InkWell(
                child: userProfilePic.isEmpty
                    ? Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.person, size: 28),
                      )
                    : Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            // border: Border.all(
                            //   color: Colors.grey[700],
                            //   width: 0.1
                            // ),
                            color: Colors.grey[300],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image:
                                    CachedNetworkImageProvider(userProfilePic),
                                fit: BoxFit.cover)),
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

  



  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    //double h = MediaQuery.of(context).size.height;

    return Scaffold(
        //backgroundColor: Colors.white,
        body: SingleChildScrollView(
      child: Column(
          children: <Widget>[
              header(w),
              searchBar(w),
              SizedBox(
                height: 10,
              ),
              Featured(),
              
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 10, bottom: 15,right: 15),
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
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey),
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
              PopularPlaces(),
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
                          style: TextStyle(fontSize: 13, color: Colors.grey),
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
              PlacesNearYou(),
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
      
    ));
  }
}
