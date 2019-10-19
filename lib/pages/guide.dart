import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:travel_hour/models/guide.dart';




class GuidePage extends StatefulWidget {
  GuidePage({Key key}) : super(key: key);

  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  Completer<GoogleMapController> _controller = Completer();

  GuideDetails _guideDetails = GuideDetails();
  MapDetails _mapDetails = MapDetails();
  List<Marker> _markers = [];
  List<Polyline> _polylines = [];

  _addMarker() {
    for (var i = 0; i < _mapDetails.placename.length; i++) {
      setState(() {
        _markers.add(
          Marker(
              markerId: MarkerId(_mapDetails.placename[i]),
              position: _mapDetails.startEndPoint[i],
              infoWindow: InfoWindow(title: _mapDetails.placename[i])),
        );
      });
    }
  }

  _addPolyline() {
    setState(() {
      _polylines.add(Polyline(
          polylineId: PolylineId('line1'),
          points: [_mapDetails.startEndPoint[0], _mapDetails.startEndPoint[1]],
          color: Colors.grey,
          visible: true,
          width: 2));
    });
  }

  @override
  void initState() {
    super.initState();
    _addMarker();
    _addPolyline();
  }

  Widget panelUI() {
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
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
            ),
          ],
        ),
        SizedBox(
          height: 18.0,
        ),
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
        Text(
          'Estimated Cost = ${_guideDetails.cost}',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 15,
        ),
        Expanded(
          child: ListView.separated(
            
            itemCount: _guideDetails.routeTitle.length,

            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                contentPadding: EdgeInsets.all(0),
                isThreeLine: true,
                leading: CircleAvatar(
                    backgroundColor: _guideDetails.colorList[index],
                    radius: 35,
                    child: Icon(
                      _guideDetails.iconList[index],
                      color: Colors.white,
                      size: 28,
                    )),
                title: Text(
                  _guideDetails.routeTitle[index],
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                    '${_guideDetails.routeSubtitle[index]}\nPrice: ${_guideDetails.routePrice[index]}'),
                trailing: CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                height: 5,
                color: Colors.grey[400],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget panelBodyUI(h, w) {
    return Container(
      width: w,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: _mapDetails.center, zoom: 10, 
            tilt: 45, 
            bearing: 45),
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set.from(_markers),
        polylines: Set.from(_polylines),
        compassEnabled: false,
        myLocationEnabled: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return new Scaffold(
        body: Stack(children: <Widget>[
      SlidingUpPanel(
           //parallaxEnabled: true,
          // parallaxOffset: 0.5,
           backdropEnabled: true,
           backdropOpacity: 0.2,
           backdropTapClosesPanel: true,
           isDraggable: true,
           
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey[400], blurRadius: 4, offset: Offset(1, 0))
          ],
          
          padding: EdgeInsets.only(top: 15, left: 10, bottom: 0, right: 10),
          panel: panelUI(),
          body: panelBodyUI(h, w)),
      Positioned(
        top: 35,
        left: 10,
        child: Container(
          height: 65,
          child: Row(
            children: <Widget>[
              InkWell(
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey[300],
                            blurRadius: 10,
                            offset: Offset(3, 3))
                      ]),
                  child: Icon(Icons.keyboard_backspace),
                ),
                onTap: () {
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
                    border: Border.all(color: Colors.grey, width: 0.5)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, top: 10, bottom: 10, right: 15),
                  child: Text(
                    'Kodomtuli Station - Bichanakandi',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    ]));
  }
}
