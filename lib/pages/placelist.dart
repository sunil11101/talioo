import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:line_icons/line_icons.dart';


import 'package:travel_hour/models/places_data.dart';
import 'package:travel_hour/pages/details.dart';


class PlaceListPage extends StatefulWidget {
  final String title;
  
  
  PlaceListPage({Key key, @required this.title}) : super(key: key);

  _PlaceListPageState createState() => _PlaceListPageState(this.title);
}

class _PlaceListPageState extends State<PlaceListPage> {

  String title;
  
  _PlaceListPageState(this.title);

    var textStyleBold = TextStyle(
      fontFamily: 'Raleway',
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.black);

  var textStyleSmallBold = TextStyle(
      fontFamily: 'Raleway',
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: Colors.black);



  var textStylicon = TextStyle(
      fontFamily: 'Raleway',
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.grey[800]);


    Widget cachedImage(index) {
    return CachedNetworkImage(
      imageUrl: imageList[index],
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
    double w = MediaQuery.of(context).size.width;
    //double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[150],
      appBar: AppBar(
        
        title: Text('$title',style: textStyleBold,),
        centerTitle: false,
        
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.black,),
        
        actions: <Widget>[
          IconButton(icon: Icon(LineIcons.bell_o), onPressed: () {},)
        ],
      ),
      body:  AnimationLimiter(
              child: ListView.builder(
          itemCount: _allData.length,
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
                                    Text(_allData[index].name,style: textStyleBold,),
                                    
                                    Text(_allData[index].location,style: TextStyle(fontSize: 12,color: Colors.grey[500],fontWeight: FontWeight.w600),),
                                                            
                                    Divider(color: Colors.grey[400],height: 20,),
                                    
                                      
                                        
                                        Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[

                                          Icon(LineIcons.heart,size: 18,color: Colors.orangeAccent,),
                                          Text(' ${_allData[index].loves}',style: textStylicon,),
                                          Spacer(),
                                          Icon(LineIcons.eye,size: 18,color: Colors.grey,),
                                          Text(' ${_allData[index].views}',style: textStylicon,),
                                          Spacer(),
                                          Icon(LineIcons.comment_o,size: 18,color: Colors.grey,),
                                          Text(' ${_allData[index].comments}',style: textStylicon,),
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
                              child: cachedImage(index),
                          
                            ),
                    )
                        )

                  
                ],
              ),

              onTap: (){
                print('hero$index');
                Navigator.push(context, MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                  placeName: _allData[index].name,
                                    placeLocation: _allData[index].location,
                                    loves: _allData[index].loves.toString(),
                                    views: _allData[index].views.toString(),
                                    comments: _allData[index].comments.toString(),
                                    picturesList: imageList,
                                    placeDetails: _allData[index].details,
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