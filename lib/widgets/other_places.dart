import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:travel_hour/blocs/places_bloc.dart';


import 'package:travel_hour/pages/details.dart';

class OtherPlaces extends StatelessWidget {
  const OtherPlaces({
    Key key,
    @required this.w,
  }) : super(key: key);

  final double w;
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
    //placesBloc.allData.isEmpty? placesBloc.getData(): print('null') ;
    
    double w = MediaQuery.of(context).size.width;
    //double h = MediaQuery.of(context).size.height;


    

    return Container(
              height: 205,
              width: w,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: placesBloc.allData.length,
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
                              width: w * 0.35,
                              child: cachedImage(index, placesBloc),

                              
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
                                placesBloc.allData[index].loves.toString(),
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
                                    child: Text(placesBloc.allData[index].name,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600))),
                                Text(placesBloc.allData[index].location,
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
