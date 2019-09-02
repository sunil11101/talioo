import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travel_hour/comments.dart';
import 'package:travel_hour/data_list.dart';
import 'package:travel_hour/placelist.dart';
import 'package:travel_hour/travel_guide.dart';


class DetailsPage extends StatefulWidget {
  
  final String placeName,placeLocation,loves,views,comments,placeDetails;
  final List picturesList;
  
  DetailsPage({Key key, @required this.placeLocation,this.loves,this.comments,this.placeName,this.picturesList,this.views,this.placeDetails}) : super(key: key);

  _DetailsPageState createState() => _DetailsPageState(this.placeLocation,this.loves,this.comments,this.placeName,this.picturesList,this.views,this.placeDetails);
}

class _DetailsPageState extends State<DetailsPage> {
  
  String placeName,placeLocation,loves,views,comments,placeDetails;
  List picturesList;
  _DetailsPageState(this.placeLocation,this.loves,this.comments,this.placeName,this.picturesList,this.views,this.placeDetails);
  

  Color heartColor = Colors.grey;
  var loveCount = 99;
  void loveIncrement() {
    setState(() {
      loveCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        //backgroundColor: Colors.white,
        body: Container(
          height: h,
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 400,
                          width: w,
                          //color: Colors.white,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey[300],
                                    blurRadius: 50,
                                    offset: Offset(5, 5))
                              ]),
                        ),

                        Positioned(
                          child: Container(
                            height: 270,
                            width: w,

                            //color: Colors.orangeAccent,
                            decoration: BoxDecoration(
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey[300],
                                    blurRadius: 50,
                                    offset: Offset(5, 5))
                              ],
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15)),
                              // image: DecorationImage(
                              //   image: NetworkImage('https://cloudfront.ualberta.ca/-/media/science/news/2019/apr/canadian-mountain-network.jpg'),
                              //   fit: BoxFit.cover
                              // )
                            ),
                            child: Carousel(
                              dotBgColor: Colors.transparent,
                              showIndicator: false,
                              dotSize: 5,
                              dotPosition: DotPosition.bottomRight,
                              boxFit: BoxFit.cover,
                              images: [
                                NetworkImage(
                                    picturesList[0]),
                                NetworkImage(
                                    picturesList[1]),
                                NetworkImage(
                                    picturesList[2]),
                                NetworkImage(
                                    picturesList[3]),
                                NetworkImage(
                                    picturesList[4]),
                                
                              ],
                            ),
                          ),
                        ),

                       

                        Positioned(
                          left: 10,
                          bottom: 130,
                          child: FlatButton.icon(
                            icon: Icon(
                              LineIcons.eye,
                              color: Colors.white,
                              size: 30,
                            ),
                            label: Text(
                              '$views views',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            onPressed: () {},
                          ),
                        ),

                        Positioned(
                          top: 40,
                          left: 10,
                          child: IconButton(
                            icon: Icon(
                              LineIcons.arrow_left,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        ),

                        Positioned(
                            bottom: 15,
                            left: 0,
                            child: Container(
                              //color: Colors.amberAccent,
                              height: 100,
                              width: w,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 20,
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.location_on,
                                              color: Colors.grey, size: 16),
                                          Text(
                                            '$placeLocation',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                          ),
                                          Spacer(),
                                          IconButton(
                                            icon: Icon(LineIcons.heart_o),
                                            onPressed: () {},
                                          ),
                                          IconButton(
                                            icon: Icon(LineIcons.bookmark_o),
                                            onPressed: () {},
                                          ),
                                          
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 30,
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
                                      color: Colors.grey[400],
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: w * 0.80,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(
                                              LineIcons.heart,
                                              size: 20,
                                              color: Colors.pinkAccent,
                                            ),
                                            Text(' $loves',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.pinkAccent)),
                                            
                                            SizedBox(width: 50,),
                                            Icon(
                                              LineIcons.comment_o,
                                              size: 20,
                                              color: Colors.grey,
                                            ),
                                            Text(' $comments',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey[800])),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ))
                      ],
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
                            '$placeDetails',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w600),
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
                SizedBox(height: 50,)

                    
                  ],
                ),
              ),
              
            ],
          ),
        ));
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
      padding: const EdgeInsets.only(
          top: 10, left: 15, right: 15, bottom: 10),
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
            height: 310,
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
                      boxShadow: <BoxShadow> [
                        BoxShadow(
                          color: Colors.grey[200],
                          offset: Offset(5, 5),
                          blurRadius: 2
                        )
                      ]
                    ),
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
                        boxShadow: <BoxShadow> [
                        BoxShadow(
                          color: Colors.blueAccent[400],
                          offset: Offset(5, 5),
                          blurRadius: 2
                        )
                      ]
                      ),
                      child: Icon(LineIcons.hand_o_left,size: 30,),
                    ),
                  ),

                  Positioned(
                    bottom: 15,
                    left: 15,
                    child: Text('Travel Guide',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 14),),
                  )
                    ],
                  ),
                  
                  onTap: (){
                    
                        showModalBottomSheet(

                            elevation: 0,
                            isScrollControlled: true,

                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10)),
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
                      boxShadow: <BoxShadow> [
                        BoxShadow(
                          color: Colors.grey[200],
                          offset: Offset(5, 5),
                          blurRadius: 2
                        )
                      ]
                    ),
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
                        boxShadow: <BoxShadow> [
                        BoxShadow(
                          color: Colors.orangeAccent[400],
                          offset: Offset(5, 5),
                          blurRadius: 2
                        )
                      ]
                      ),
                      child: Icon(LineIcons.hotel,size: 30,),
                    ),
                  ),

                  Positioned(
                    bottom: 15,
                    left: 15,
                    child: Text('Nearby Hotels',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 14),),
                  )
                    ],
                  ),

                  onTap: (){
                    
                        showModalBottomSheet(

                            elevation: 0,
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10)),
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
                      boxShadow: <BoxShadow> [
                        BoxShadow(
                          color: Colors.grey[200],
                          offset: Offset(5, 5),
                          blurRadius: 2
                        )
                      ]
                    ),
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
                        boxShadow: <BoxShadow> [
                        BoxShadow(
                          color: Colors.pinkAccent[400],
                          offset: Offset(5, 5),
                          blurRadius: 2
                        )
                      ]
                      ),
                      child: Icon(Icons.restaurant),
                    ),
                  ),

                  Positioned(
                    bottom: 15,
                    left: 15,
                    child: Text('Nearby Restaurents',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 14),),
                  )
                    ],
                  ),

                  onTap: (){
                    
                        showModalBottomSheet(

                            elevation: 0,
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10)),
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
                      color: Colors.indigoAccent,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: <BoxShadow> [
                        BoxShadow(
                          color: Colors.grey[200],
                          offset: Offset(5, 5),
                          blurRadius: 2
                        )
                      ]
                    ),
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
                        boxShadow: <BoxShadow> [
                        BoxShadow(
                          color: Colors.indigoAccent[400],
                          offset: Offset(5, 5),
                          blurRadius: 2
                        )
                      ]
                      ),
                      child: Icon(LineIcons.comments, size:  30,),
                    ),
                  ),

                  Positioned(
                    bottom: 15,
                    left: 15,
                    child: Text('User Reviews',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 14),),
                  )
                    ],
                  ),

                  onTap: (){
                    
                        showModalBottomSheet(

                            elevation: 0,
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10)),
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
