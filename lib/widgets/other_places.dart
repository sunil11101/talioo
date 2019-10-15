import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'package:travel_hour/models/places_data.dart';
import 'package:travel_hour/pages/details.dart';

class OtherPlaces extends StatefulWidget {
  const OtherPlaces({
    Key key,
    @required this.w,
  }) : super(key: key);

  final double w;

  @override
  _OtherPlacesState createState() => _OtherPlacesState();
}

class _OtherPlacesState extends State<OtherPlaces> {

  List<PlaceData1> _allData = [];
  PlaceData placeData = PlaceData();

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
    }
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }


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
              width: widget.w,
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
                            tag: 'heroOtherPlaces $index',
                                                      child: Container(
                              height: 200,
                              width: widget.w * 0.35,
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
                                    width: widget.w * 0.32,
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
                                    loves: _allData[index].loves.toString(),
                                    views: _allData[index].views.toString(),
                                    comments: _allData[index].comments.toString(),
                                    picturesList: imageList,
                                    placeDetails: _allData[index].details,
                                      heroTag: 'heroOtherPlaces$index',
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
