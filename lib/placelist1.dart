import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travel_hour/data_list.dart';
import 'package:travel_hour/details.dart';



class PlaceListPage1 extends StatefulWidget {
  PlaceListPage1({Key key}) : super(key: key);

  _PlaceListPage1State createState() => _PlaceListPage1State();
}

class _PlaceListPage1State extends State<PlaceListPage1> {




  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Explore Places'),
        
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 0,left: 15,right: 15,bottom: 5),
            child: Container(
              alignment: Alignment.centerLeft,
              height: 50,
              width: w,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey[400],width: 0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text('Search Places & Explore'),
              ),
              
            ),
          ),

          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.only(left: 15,right: 15,top: 10),
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 0.8,
              children: List.generate(placeNameList.length, (index){
                return InkWell(
                                  child: GridTile(
                    
                    child: Stack(
                      children: <Widget>[
                        Container(
                      
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: <BoxShadow> [
                          BoxShadow(
                            blurRadius: 2,
                            color: Colors.grey[200],
                            offset: Offset(5, 5)
                          )
                        ],
                        image: DecorationImage(

                          image: NetworkImage(imageList[index],),
                          fit: BoxFit.cover
                        )
                      ),                  
                    ),

                    Positioned(
                      bottom: 30,
                      left: 10,
                      child: Text(placeNameList[index],style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w700),),
                    ),

                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Text(locationList[index],style: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.w500),),
                    ),

                    Positioned(
                      top: 10,
                      right: 0,
                      child: FlatButton.icon(
                        color: Colors.grey[600].withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),topLeft: Radius.circular(10))
                        ),
                        icon: Icon(LineIcons.heart,color: Colors.white,size: 25,), label: Text('${loveList[index]}',style: TextStyle(color: Colors.white, fontSize: 15),), onPressed: () {
                              
                            },),
                    )
                      ],
                    )
                    
                    
                    
                    
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
                );
              }),

            )
          )
        ],
      ),
    );
  }
}