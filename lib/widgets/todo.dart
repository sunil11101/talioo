import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:talio_travel/pages/comments.dart';
import 'package:talio_travel/pages/guide.dart';
import 'package:talio_travel/pages/hotel.dart';
import 'package:talio_travel/pages/restaurant.dart';


// used in place details page

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
            
            //color: Colors.brown,
            height: 330,
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
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => GuidePage()
                    ));
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
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => HotelPage()
                    ));
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
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => RestaurantPage()
                    ));
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
                    // shoing popup page
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