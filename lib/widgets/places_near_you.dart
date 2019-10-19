import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'package:travel_hour/models/places_data.dart';
import 'package:travel_hour/pages/details.dart';


class PlacesNearYou extends StatefulWidget {
  PlacesNearYou({Key key}) : super(key: key);

  _PlacesNearYouState createState() => _PlacesNearYouState();
}

class _PlacesNearYouState extends State<PlacesNearYou> {

  PlaceData placeData = PlaceData();
  List<PlaceData1> _allData = [];

    _getData(){
    for (var i = 0; i < placeData.placeName.length; i++) {
      PlaceData1 d = PlaceData1(
        placeData.image[i], 
        placeData.placeName[i],
        placeData.location[i], 
        placeData.loves[i], 
        placeData.views[i], 
        placeData.comments[i], 
        placeData.placeDeatails[i],
        placeData.imageList[i]
        
        );
      _allData.add(d);
      _allData.sort((a,b) => b.views.compareTo(a.views));
      
    }
  }

  Widget cachedImage(index) {
    return CachedNetworkImage(
      imageUrl: _allData[index].image,
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


  

  @override
  void initState() {
    
    _getData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    //double h = MediaQuery.of(context).size.height;
    return Container(
              height: 205,
              width: w,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _allData.length,
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
                                _allData[index].loves.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13),
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
                                    child: Text(_allData[index].name,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600))),
                                Text(_allData[index].location,
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
                                      placeName: _allData[index].name,
                                    placeLocation: _allData[index].location,
                                    loves: _allData[index].loves,
                                    views: _allData[index].views,
                                    comments: _allData[index].comments,
                                    picturesList: _allData[index].imageList,
                                    placeDetails: _allData[index].details,
                                      heroTag: 'heroPlacesNearYou$index',
                                      placeIndex: index,
                                    )));
                      },
                    ),
                  );
                },
              ),
            );
  }
}