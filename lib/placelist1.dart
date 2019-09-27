import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travel_hour/data_list.dart';
import 'package:travel_hour/details.dart';



class PlaceListPage1 extends StatefulWidget {
  PlaceListPage1({Key key}) : super(key: key);

  _PlaceListPage1State createState() => _PlaceListPage1State();
}

class _PlaceListPage1State extends State<PlaceListPage1> {

  String txt = 'SUGGESTED PLACES';
  var formKey = GlobalKey<FormState>();
  var textFieldCtrl = TextEditingController();


  


  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 24,),

          // search bar

          Container(
              alignment: Alignment.center,
              height: 65,
              width: w,
              decoration: BoxDecoration(
                //color: Colors.white
              ),
              child: Form(
                    key: formKey,
                    child: TextFormField(
                        
                        //autofocus: true,
                        controller: textFieldCtrl,
                        style: TextStyle(fontSize: 18, color: Colors.grey[700],fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                          
                          border: InputBorder.none,
                          hintText: "Search & Explore Places",
                          hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[500]),
                          
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15),
                            child: IconButton(
                              icon: Icon(Icons.keyboard_backspace,color: Colors.grey[800],),
                              color: Colors.grey[800],
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.close,color: Colors.grey[800],size: 25,),
                            onPressed: () {
                              setState(() {
                                textFieldCtrl.clear();
                              });
                            },
                          ),
                        ),
                        

                        //keyboardType: TextInputType.datetime,

                        validator: (value) {
                          if (value.length == 0)
                            return ("Comments can't be empty!");

                          return value = null;
                        },
                        onSaved: (String value) {
                          setState(() {
                            
                          });
                        }),
                ),
                  
               
            ),
          
          
          Container(
            height: 1,
            child: Divider(color: Colors.grey,),
          ),


          // suggestion text

          Padding(
            padding: const EdgeInsets.only(top: 15,left: 15,bottom: 5),
            child: Text(txt,textAlign: TextAlign.left,style: TextStyle(
              color: Colors.grey[800],
              fontSize: 10,
              fontWeight: FontWeight.w700
            ),),
          ),


          // suggestion list

          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.only(left: 15,right: 15,top: 10),
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 0.8,
              children: List.generate(placeNameList.length, (index){
                return InkWell(
                    child: Hero(
                      tag: 'heroExplore$index',
                                          child: GridTile(
                      
                      child: Stack(
                        children: <Widget>[
                          Container(

                          child: CachedNetworkImage(
                                  imageUrl: imageList[index],
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                      decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      shape: BoxShape.rectangle,
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: Colors.grey[200],
                                            offset: Offset(5, 5),
                                            blurRadius: 2),
                                      ],
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      Icon(LineIcons.photo,size: 30,),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                        
                        // decoration: BoxDecoration(
                        //   color: Colors.white,
                        //   borderRadius: BorderRadius.circular(10),
                        //   boxShadow: <BoxShadow> [
                        //     BoxShadow(
                        //       blurRadius: 2,
                        //       color: Colors.grey[200],
                        //       offset: Offset(5, 5)
                        //     )
                        //   ],
                        //   image: DecorationImage(

                        //     image: NetworkImage(imageList[index],),
                        //     fit: BoxFit.cover
                        //   )
                        // ),                  
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
                        right: 10,
                        child: Container(
                          width: 80,
                          child: FlatButton.icon(
                            padding: EdgeInsets.all(0),
                            
                            color: Colors.grey.withOpacity(0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                            ),
                            icon: Icon(LineIcons.heart,color: Colors.white,size: 25,), label: Text('${loveList[index]}',style: TextStyle(color: Colors.white, fontSize: 15),), onPressed: () {
                                  
                                },),
                        ),
                      )
                        ],
                      )
                      
                      
                      
                      
                  ),
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
                                heroTag: 'heroExplore$index',
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