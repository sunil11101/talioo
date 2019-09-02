import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travel_hour/data_list.dart';

import 'details.dart';

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




  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
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
      body:  ListView.builder(
        itemCount: placeNameList.length,
        itemBuilder: (BuildContext context, int index) {
        return  InkWell(
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
                                  Text(placeNameList[index],style: textStyleBold,),
                                  
                                  Text(locationList[index],style: TextStyle(fontSize: 13),),
                                                          
                                  Divider(color: Colors.grey[400],height: 20,),
                                  
                                    
                                      
                                       Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[

                                        Icon(LineIcons.heart,size: 18,color: Colors.orangeAccent,),
                                        Text(' 20',style: textStylicon,),
                                        Spacer(),
                                        Icon(LineIcons.eye,size: 18,color: Colors.grey,),
                                        Text(' 2000',style: textStylicon,),
                                        Spacer(),
                                        Icon(LineIcons.comment_o,size: 18,color: Colors.grey,),
                                        Text(' 24',style: textStylicon,),
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
                        child: Container(
                          
                          
                          height: 120,
                          width: 120,
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
                        image: DecorationImage(
                          image: NetworkImage(imageList[index]),
                          fit: BoxFit.cover
                        )
                      ),
                      
                        ),
                      )

                
              ],
            ),

            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                            builder: (context) => DetailsPage(
                                placeName: placeNameList[index],
                                placeLocation: locationList[index],
                                loves: loveList[index],
                                views: viewList[index],
                                comments: commentList[index],
                                picturesList: imageList,
                                placeDetails: placeDeatailsList[index],
                            ) ));
            },
        ) ;
       },
      ),
      
      
      
      
      
      
        
      
                  
               
    );
  }
}