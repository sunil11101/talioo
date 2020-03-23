import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:talio_travel/blocs/places_bloc.dart';


import 'package:talio_travel/pages/details.dart';
import 'package:talio_travel/models/variables.dart';

class Featured extends StatefulWidget {
  Featured({Key key}) : super(key: key);

  _FeaturedState createState() => _FeaturedState();
}

class _FeaturedState extends State<Featured> {
  
  
  int listIndex = 2;

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
    final PlacesBloc placesBloc = Provider.of<PlacesBloc>(context); // to access place data
    double w = MediaQuery.of(context).size.width;
    
    return Column(
      children: <Widget>[
        Container(
          height: 305,
          width: w,
          child: PageView.builder(
            controller: PageController(
              initialPage: 2
            ),
            scrollDirection: Axis.horizontal,
            itemCount: placesBloc.allData.length,

            

            onPageChanged: (index) {
              setState(() {
                listIndex = index;
                print(listIndex);
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SizedBox(
                  height: 300,
                  width: w,
                  child: InkWell(
                    child: Stack(
                      children: <Widget>[
                        Hero(
                          tag: 'heroFeatured$index',
                          child: Container(
                            height: 250,
                            width: w,
                            child: cachedImage(index, placesBloc),
                          ),
                        ),
                        Positioned(
                          height: 120,
                          width: w * 0.70,
                          left: w * 0.11,
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
                                    placesBloc.allData[index].name,
                                    style: textStyleBold,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.location_on,
                                        size: 14,
                                        color: Colors.grey,
                                      ),
                                      Text(placesBloc.allData[index].location,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey[500]))
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
                                          LineIcons.heart,
                                          size: 18,
                                          color: Colors.orange,
                                        ),
                                        Text(
                                          placesBloc.allData[index].loves.toString(),
                                          style: textStylicon,
                                        ),
                                        Spacer(),
                                        Icon(
                                          LineIcons.eye,
                                          size: 18,
                                          color: Colors.orange,
                                        ),
                                        Text(
                                          placesBloc.allData[index].views.toString(),
                                          style: textStylicon,
                                        ),
                                        Spacer(),
                                        Icon(
                                          LineIcons.comment_o,
                                          size: 18,
                                          color: Colors.orange,
                                        ),
                                        Text(
                                          placesBloc.allData[index].comments.toString(),
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
                      setState(() {
                        listIndex = index;
                      });
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
                                    heroTag: 'heroFeatured$index',
                                    placeIndex: index,
                                  )));
                    },
                  ),
                ),
              );
            },
          ),
        ),

        
        DotsIndicator(
          dotsCount: 5,
          position: listIndex.toDouble(),                                       // showing dots animation
          decorator: DotsDecorator(
            size: const Size.square(8.0),
            activeSize: const Size(16.0, 8.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        )
      ],
    );
  }
}
