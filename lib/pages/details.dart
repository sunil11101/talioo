import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:talio_travel/blocs/places_bloc.dart';
import 'package:talio_travel/pages/placelist.dart';
import 'package:talio_travel/widgets/other_places.dart';
import 'package:talio_travel/widgets/todo.dart';


// place details page


// geting data for selected place
class DetailsPage extends StatelessWidget {
  final String placeName, placeLocation,placeDetails,heroTag;
  final List picturesList;
  final int loves, views, comments, placeIndex;
  

  DetailsPage(
      {Key key,
      @required 
      this.placeName,
      this.placeLocation,
      
      this.placeDetails,
      this.heroTag,
      this.picturesList,
      this.loves,
      this.views,
      this.comments,
      this.placeIndex
      })
      : super(key: key);





  // this is callback function and using cached image for saving online images
  Widget cachedImage(index) {
    return CachedNetworkImage(
      imageUrl: picturesList[index],
      imageBuilder: (context, imageProvider) => Container(
        height: 280,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
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

  

  @override
  Widget build(BuildContext context) {
    final PlacesBloc placesBloc = Provider.of<PlacesBloc>(context); //to access place data
    
    
    
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
                          cachedImage(2),     //slideshow
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
                            icon: placesBloc.loveIcon,
                            iconSize: 28,
                            onPressed: () {
                              placesBloc.loveIconClicked(placeIndex, placeName);
                              
                              
                            },
                          ),
                          
                          IconButton(
                            icon: placesBloc.bookmarkIcon,
                            iconSize: 28,
                            onPressed: () {
                              placesBloc.bookmarkIconClicked(placeIndex, placeName, context);  //after bookmark icon clicks
                              placesBloc.getBookmarkedPlaceList();     //getting bookmarked places list
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
                            Text(' ${placesBloc.allData[placeIndex].views}',
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
                            Text(' ${placesBloc.allData[placeIndex].loves}',
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
                            Text(' ${placesBloc.allData[placeIndex].comments}',
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