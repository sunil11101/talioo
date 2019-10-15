import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'package:travel_hour/models/places_data.dart';
import 'package:travel_hour/pages/details.dart';
import 'package:travel_hour/variables.dart';

class Featured extends StatefulWidget {
  Featured({Key key}) : super(key: key);

  _FeaturedState createState() => _FeaturedState();
}

class _FeaturedState extends State<Featured> {

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
        placeData.placeDeatails[i]
        
        );
      _allData.add(d);
      _allData.sort((a,b) => a.loves.compareTo(b.loves));
      
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
      height: 305,
      width: w,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _allData.length,
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
                                    _allData[index].name,
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
                                      Text(_allData[index].location,style: TextStyle(
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
                                          _allData[index].loves.toString(),
                                          style: textStylicon,
                                        ),
                                        Spacer(),
                                        Icon(
                                          LineIcons.eye,
                                          size: 18,
                                          color: Colors.orange,
                                        ),
                                        Text(
                                          _allData[index].views.toString(),
                                          style: textStylicon,
                                        ),
                                        Spacer(),
                                        Icon(
                                          LineIcons.comment_o,
                                          size: 18,
                                          color: Colors.orange,
                                        ),
                                        Text(
                                          _allData[index].comments.toString(),
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
                                    placeName: _allData[index].name,
                                    placeLocation: _allData[index].location,
                                    loves: _allData[index].loves.toString(),
                                    views: _allData[index].views.toString(),
                                    comments: _allData[index].comments.toString(),
                                    picturesList: imageList,
                                    placeDetails: _allData[index].details,
                                    heroTag: 'heroFeatured$index',
                                    placeIndex: index,
                                  )));
                    },
                  ),
                ),
              
            
          );
        },
      ),
    );
  }
}