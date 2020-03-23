import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:talio_travel/blocs/places_bloc.dart';

import 'package:talio_travel/pages/details.dart';
import 'package:talio_travel/models/variables.dart';


// placeList of particular places


class PlaceListPage extends StatelessWidget {
  final String title;  
  
  
  PlaceListPage({Key key, @required this.title}) : super(key: key);


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
    
    return Scaffold(
      backgroundColor: Colors.grey[150],
      appBar: AppBar(
        brightness: Platform.isAndroid ? Brightness.dark : Brightness.light,
        title: Text('$title',style: textStyleBold,),
        centerTitle: false,
        
        elevation: 0,
        
        
        
      ),
      body:  AnimationLimiter(               // used for listview animation
              child: ListView.builder(
          itemCount: placesBloc.allData.length,
          itemBuilder: (BuildContext context, int index) {
          return  AnimationConfiguration.staggeredList(
                position: index,
                duration: Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50,
                  child: FadeInAnimation(
                    child: InkWell(
                    child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.bottomRight,
                    height: 160,
                    width: w,
                    //color: Colors.cyan,
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            
                            height: 120,
                            width: w* 0.87,
                            decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: <BoxShadow> [
                            BoxShadow(
                              color: Colors.grey[200],
                              blurRadius: 2,
                              offset: Offset(5, 5),
                            )
                          ],
                        ),
                            child: Padding(
                                padding: const EdgeInsets.only(top: 15,left: 110),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(placesBloc.allData[index].name,style: textStyleBold,),
                                    
                                    Text(placesBloc.allData[index].location,style: TextStyle(fontSize: 12,color: Colors.grey[500],fontWeight: FontWeight.w600),),
                                                            
                                    Divider(color: Colors.grey[400],height: 20,),
                                    
                                      
                                        
                                        Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[

                                          Icon(LineIcons.heart,size: 18,color: Colors.orangeAccent,),
                                          Text(' ${placesBloc.allData[index].loves}',style: textStylicon,),
                                          Spacer(),
                                          Icon(LineIcons.eye,size: 18,color: Colors.grey,),
                                          Text(' ${placesBloc.allData[index].views}',style: textStylicon,),
                                          Spacer(),
                                          Icon(LineIcons.comment_o,size: 18,color: Colors.grey,),
                                          Text(' ${placesBloc.allData[index].comments}',style: textStylicon,),
                                          Spacer(),



                                          

                                          
                                        ],
                                      ),
                                    


                                    
                                  ],
                                ),
                              ),
                          ),
                        ),

                        
                      ],
                    ),
                  ),

                  Positioned(
                    bottom: 25,
                    left: 12,
                    child: Hero(
                      tag: 'hero$index',
                              child: Container(
                              
                              
                              height: 120,
                              width: 120,
                              child: cachedImage(index, placesBloc),
                          
                            ),
                    )
                        )

                  
                ],
              ),

            onTap: (){
            placesBloc.viewsIncrement(index);
            placesBloc.loveIconCheck(placesBloc.allData[index].name);
            placesBloc.bookmarkIconCheck(placesBloc.allData[index].name);
                Navigator.push(context, MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                  placeName: placesBloc.allData[index].name,
                                    placeLocation: placesBloc.allData[index].location,
                                    loves: placesBloc.allData[index].loves,
                                    views: placesBloc.allData[index].views,
                                    comments: placesBloc.allData[index].comments,
                                    picturesList: placesBloc.allData[index].imageList,
                                    placeDetails: placesBloc.allData[index].details,
                                  heroTag: 'hero$index',
                                  placeIndex: index,
                              ) ));
              },
          ) 
                )));
          
          
          
          
         },
        ),
      ),
      
      
      
      
      
      
        
      
                  
               
    );
  }
}