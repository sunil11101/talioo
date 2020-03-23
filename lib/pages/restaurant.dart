import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:http/http.dart' as http;
import 'package:talio_travel/models/restaurant.dart';


// similliar as hotel page >> see hotels page comments

class RestaurantPage extends StatefulWidget {
  RestaurantPage({Key key}) : super(key: key);

  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  GoogleMapController _controller;
  List<Restaurant> _allData = [];
  PageController _pageController;
  int prevPage;
  List _markers = [];

  void getData() async {
    http.Response response = await http
        .get('https://maps.googleapis.com/maps/api/place/nearbysearch/json' +
            '?location=24.895575,91.8668725' +
            '&radius=1500' +
            '&type=restaurant' +
            //'&keyword=food'+
            '&key=AIzaSyA-fE7BtlehhXxsO_sWnHpayWen9Dcg3Bs');

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      print(decodedData);

      for (var i = 0; i < 15; i++) {
        Restaurant d = Restaurant(
            decodedData['results'][i]['name'],
            decodedData['results'][i]['vicinity'],
            decodedData['results'][i]['geometry']['location']['lat'],
            decodedData['results'][i]['geometry']['location']['lng'],
            decodedData['results'][i]['rating'],
            decodedData['results'][i]['price_level'] ?? 0,
            decodedData['results'][i]['opening_hours']['open_now'] ?? true);

        _allData.add(d);
        _allData.sort((a, b) => b.rating.compareTo(a.rating));
      }

      _addMarker();
    }
  }

  _addMarker() {
    for (var data in _allData) {
      setState(() {
        _markers.add(Marker(
            markerId: MarkerId(data.name),
            position: LatLng(data.lat, data.lng),
            infoWindow: InfoWindow(title: data.name, snippet: data.address),
            onTap: () {}));
      });
    }
  }

  void _onScroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
      moveCamera();
    }
  }

  @override
  void initState() {
    getData();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);
    super.initState();
  }

  _restaurantList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 140.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
          onTap: () {
            _onCardTap(index);
          },
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            padding: EdgeInsets.only(top: 15, left: 10, right: 5, bottom: 10),
            //height: 150,
            //width: 350,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey[300],
                      blurRadius: 10,
                      offset: Offset(3, 3))
                ]),
            child: Row(
              children: <Widget>[
                Image(
                  image: AssetImage('assets/images/restaurant.png'),
                  height: 60,
                  width: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 0, right: 0),
                  child: Container(
                    width: 183,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _allData[index].name,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          _allData[index].address,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              height: 20,
                              width: 90,
                              child: ListView.builder(
                                itemCount: _allData[index].rating.round(),
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return Icon(
                                    LineIcons.star,
                                    color: Colors.orangeAccent,
                                    size: 18,
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              '(${_allData[index].rating})'.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  _onCardTap(index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              height: 500,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 10, right: 5),
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.orangeAccent,
                    child: Row(
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/restaurant.png'),
                          height: 120,
                          width: 120,
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            _allData[index].name,
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        )),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15, left: 15, right: 5),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: Colors.orangeAccent,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                _allData[index].address,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Colors.orangeAccent,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Rating : ${_allData[index].rating}/5',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.opacity,
                              color: Colors.orangeAccent,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Text(
                              _allData[index].price == 0
                                  ? 'Price : Moderate'
                                  : _allData[index].price == 1
                                      ? 'Price : Inexpensive'
                                      : _allData[index].price == 2
                                          ? 'Price : Moderate'
                                          : _allData[index].price == 3
                                              ? 'Price : Expensive'
                                              : 'Price : Very Expensive',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ))
                          ],
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.timer,
                              color: Colors.orangeAccent,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Text(
                              _allData[index].openingHour == false
                                  ? 'Openning Hour : Closed Now'
                                  : 'Openning Hour : Open Now',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    alignment: Alignment.bottomRight,
                    height: 50,
                    child: FlatButton(
                      child: Text('Close'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            compassEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
                bearing: 45.0,
                tilt: 45.0,
                target: LatLng(24.895575, 91.8668725),
                zoom: 15.0),
            markers: Set.from(_markers),
            onMapCreated: mapCreated,
          ),
        ),
        Positioned(
          bottom: 20.0,
          child: Container(
            height: 200.0,
            width: MediaQuery.of(context).size.width,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _allData.length,
              itemBuilder: (BuildContext context, int index) {
                return _restaurantList(index);
              },
            ),
          ),
        ),
        Positioned(
            top: 40,
            left: 15,
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
                  width: 15,
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
                      'Explore Nearby Restaurants',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ))
      ],
    ));
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  moveCamera() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(_allData[_pageController.page.toInt()].lat,
            _allData[_pageController.page.toInt()].lng),
        zoom: 18,
        bearing: 45.0,
        tilt: 45.0)));
  }
}
