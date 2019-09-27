

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as prefix0;
import 'package:line_icons/line_icons.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapTest extends StatefulWidget {
  MapTest({Key key}) : super(key: key);

  _MapTestState createState() => _MapTestState();
}

class _MapTestState extends State<MapTest> {
  Completer<GoogleMapController> _controller = Completer();


  Set<Marker> _myMarkers = Set<Marker>();
  List<Marker> markerList = <Marker>[];
  List markerIDlist = ['a','b'];
  
  
  void _buttonPressed (){
    for (var item in markerIDlist) {
      markerList.add(
    
      Marker(
    markerId: MarkerId(item),
    position: LatLng(24.9240494,91.8304851),
    infoWindow: InfoWindow(title: 'Central Auditoriam')
      )
    );
    }
    
  }

  @override
  void initState() { 
    super.initState();
    _buttonPressed();
    
  }

  Widget panelUI (){
    return Column(
      children: <Widget>[
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 30,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(12.0))
              ),
            ),
          ],
        ),

        SizedBox(height: 18.0,),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Travel Guide",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24.0,
              ),
            ),
          ],
        ),
        Text('Estimated Cost = 500TK/Person',style: TextStyle(
          fontSize: 16
        ),),

        SizedBox(height: 15,),
              
            Expanded(
                      child: ListView.separated(
                          //physics: NeverScrollableScrollPhysics(),
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            contentPadding: EdgeInsets.all(0),
                            isThreeLine: true,
                            leading: CircleAvatar(
                              backgroundColor: Colors.purpleAccent,
                              radius: 35,
                              child: Icon(LineIcons.map,color: Colors.white,size: 28,)),
                            title: Text('Kodomtuli to Amborkhana',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                            subtitle: Text('By CNG \nCNG Price : 20tk/person'),
                            trailing: CircleAvatar(
                              backgroundColor: Colors.grey[300],
                              child: Text('${index+1}',style: TextStyle(color: Colors.grey[600]),),
                            ),

                          );
                         }, separatorBuilder: (BuildContext context, int index) {
                           return Divider(color: Colors.grey[400],);
                         },
                        ),
                      ),
      ],
    );
  }

  Widget panelBodyUI(h,w) {
    
    return Container(
          //height:  h * 0.80,
          width: w,
          child: GoogleMap(
            zoomGesturesEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition: CameraPosition(target: LatLng(24.9285002,91.8153235),zoom: 10),
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
            },
          markers: {
            amborkhana,
            bichnakandi
          },
          polylines: {
            line1
          },

          // polygons: {
          //   route1
          // },

          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return new Scaffold(
      body: Stack(
              children: <Widget> [
          SlidingUpPanel(
          
          parallaxEnabled: true,
          parallaxOffset: 0.5,
          backdropEnabled: true,
          backdropOpacity: 0.2,
          borderRadius: BorderRadius.only(topLeft:Radius.circular(15), topRight: Radius.circular(15)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey[400],
              blurRadius: 4,
              offset: Offset(1,0)
            )
          ],
          padding: EdgeInsets.all(15),
          panel: panelUI(),
          body: panelBodyUI(h,w)
        ),

        Positioned(
          
          top: 30,
          left: 10,
          child: Container(
              height: 65,
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(LineIcons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey,width: 0.5)
                      

                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15,top: 10,bottom: 10,right: 15),
                      child: Text(
                        'Amborkhana Point - Bichanakandi',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        )
              ])
  
    );
  
  }

  Marker amborkhana = Marker(
    markerId: MarkerId('marker1'),
    position: LatLng(24.9285002,91.8153235),
    infoWindow: InfoWindow(title: 'Central Auditoriam')
  );

  Marker bichnakandi = Marker(
    markerId: MarkerId('marker2'),
    position: LatLng(25.1720151,91.8803782),
    infoWindow: InfoWindow(title: 'Cafeteria')
  );

 



  Polyline line1 = Polyline(
    polylineId: PolylineId('line1'),
    color: Colors.grey,
    width: 2,
    visible: true,
    points: [
      LatLng(24.9285002,91.8153235),
      LatLng(25.1720151,91.8803782),

    ]
  );

  Polygon route1 = Polygon(
    polygonId: PolygonId('route1'),
    
    visible: true,
    points: [
      LatLng(24.9240494,91.8304851),
      LatLng(24.9253337,91.8351396),]
  );
  

  
}