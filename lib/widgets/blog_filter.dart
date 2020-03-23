import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:talio_travel/blocs/places_bloc.dart';

import 'package:talio_travel/pages/details.dart';

// used in blog
class BlogFilter extends StatelessWidget {
  BlogFilter({Key key}) : super(key: key);


  // this is callback function and using cached image for saving online images
  Widget cachedImage(index, placesBloc) {
    return CachedNetworkImage(
      imageUrl: placesBloc.allData[index].image,
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
  Widget build(BuildContext context) {
    final PlacesBloc placesBloc = Provider.of<PlacesBloc>(context);
    
    
    double w = MediaQuery.of(context).size.width;
    //double h = MediaQuery.of(context).size.height;


    return Container(
      margin: const EdgeInsets.only(top: 100),
              height: 106,
              width: w,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: placesBloc.allData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: SizedBox(
                      width: 80,
                      child: InkWell(
                        child: Stack(
                          children: <Widget>[
                            Hero(
                              tag: 'heroPopular$index',
                                child: Container(
                                height: 80,
                                width: 80,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    child: cachedImage(index, placesBloc),
                                  ),
                              ),
                            ),
                            Positioned(
                              bottom: 23,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                      width: 80,
                                      child: Center(
                                          child:Text(placesBloc.allData[index].name,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)))),
                                ],
                              ),
                            ),
                            /*Padding(
                                padding: const EdgeInsets.only(top: 85),
                                child:RichText(
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  text:TextSpan(
                                    text:placesBloc.allData[index].name,
                                    style: TextStyle(color: Colors.black87, fontSize: 12),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                            ),*/
                          ],
                        ),
                        onTap: () {
                        placesBloc.viewsIncrement(index);
                        placesBloc.loveIconCheck(placesBloc.allData[index].name);
                        placesBloc.bookmarkIconCheck(placesBloc.allData[index].name);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsPage(
                                      placeName: placesBloc.allData[index].name,
                                      placeLocation: placesBloc.allData[index].location,
                                      loves: placesBloc.allData[index].loves,
                                      views: placesBloc.allData[index].views,
                                      comments: placesBloc.allData[index].comments,
                                      picturesList: placesBloc.allData[index].imageList,
                                      placeDetails: placesBloc.allData[index].details,
                                        heroTag: 'heroPopular$index',
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