import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travel_hour/details.dart';
import 'package:travel_hour/placelist.dart';
import 'package:travel_hour/placelist1.dart';
import 'package:travel_hour/data_list.dart';
import 'package:travel_hour/variables.dart';

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

  

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
        

        //backgroundColor: Colors.grey[200],
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 20, right: 10, bottom: 20),
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Travel Hour',
                                style: TextStyle(
                                    fontFamily: 'Raleway',
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                ' Explore Bangladesh',
                                style: TextStyle(
                                    fontFamily: 'Raleway',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[600]),
                              )
                            ],
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(
                              CupertinoIcons.search,
                              size: 35,
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => PlaceListPage1()
                              ));
                            },
                          )
                        ],
                      ),
                    )),

                //Featured

                Container(
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
                                Container(
                                  height: 250,
                                  width: w * 0.80,
                                  //margin: EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      shape: BoxShape.rectangle,
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: Colors.grey[200],
                                            offset: Offset(5, 5),
                                            blurRadius: 2),
                                      ],
                                      image: DecorationImage(
                                          image: NetworkImage(imageList[index]),
                                          fit: BoxFit.cover)),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            ' ${placeNameList[index]}',
                                            style: textStyleBold,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                Icons.location_on,
                                                size: 16,
                                                color: Colors.grey,
                                              ),
                                              Text(locationList[index])
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.grey[300],
                                            height: 20,
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Icon(
                                                  LineIcons.eye,
                                                  size: 18,
                                                  color: Colors.orange,
                                                ),
                                                Text(
                                                  ' ${viewList[index]}',
                                                  style: textStylicon,
                                                ),
                                                SizedBox(
                                                  width: 40,
                                                ),
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
                                Positioned(
                                  right: 0,
                                  top: 10,
                                  child: FlatButton.icon(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            topLeft: Radius.circular(10))),
                                    color: Colors.grey[600].withOpacity(0.5),
                                    icon: Icon(
                                      LineIcons.heart,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                    label: Text(
                                      '${loveList[index]}',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    onPressed: () {},
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
                                            placeDetails:
                                                placeDeatailsList[index],
                                          )));
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),

                //Popular Places

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
                            style: TextStyle(fontSize: 13),
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

                Container(
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
                              Container(
                                height: 200,
                                width: w * 0.35,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: Colors.grey[200],
                                          offset: Offset(5, 5),
                                          blurRadius: 2)
                                    ],
                                    image: DecorationImage(
                                        image: NetworkImage(imageList[index]),
                                        fit: BoxFit.cover)),
                              ),
                              Positioned(
                                right: 0,
                                top: 8,
                                child: FlatButton.icon(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          topLeft: Radius.circular(10))),
                                  color: Colors.grey[600].withOpacity(0.5),
                                  icon: Icon(
                                    LineIcons.heart,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  label: Text(
                                    '120',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
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
                          onTap: (){
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
                                            placeDetails:
                                                placeDeatailsList[index],
                                          )));
                          },
                        ),
                      );
                    },
                  ),
                ),

                //places near you

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

                Container(
                  height: 205,
                  width: w,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: placeNameList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 200,
                              width: w * 0.35,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.grey[200],
                                        offset: Offset(5, 5),
                                        blurRadius: 2)
                                  ],
                                  image: DecorationImage(
                                      image: NetworkImage(imageList[index]),
                                      fit: BoxFit.cover)),
                            ),
                            Positioned(
                              right: 0,
                              top: 2,
                              child: FlatButton.icon(
                                  icon: Icon(
                                    LineIcons.heart,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  label: Text(
                                    '200',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                  onPressed: () {}),
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
                      );
                    },
                  ),
                ),

                // Places by division

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

                Container(
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
                                    blurRadius: 2)
                              ]),
                          child: ListTile(
                            leading: CircleAvatar(
                                child:
                                    Icon(LineIcons.location_arrow, size: 25)),
                            title: Text(
                              placesByLocation[index],
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                              '212 Places',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            trailing: IconButton(
                              icon: Icon(LineIcons.arrow_right),
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
                )
              ],
            )
          ],
        ));
  }
}
