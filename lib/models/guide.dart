import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_icons/line_icons.dart';

class GuideDetails {
  String cost = '500TK/Person';
  List iconList = [
    LineIcons.car,
    LineIcons.rub,
    LineIcons.bus,
    Icons.directions_boat
  ];
  List colorList = [
    Colors.blueAccent,
    Colors.orangeAccent,
    Colors.pinkAccent,
    Colors.greenAccent
  ];

  List<String> routeTitle = [
    'Kodomtuli to Bondor',
    'Bondor to Amborkhana Point',
    'Amborkhana Point to Gowainghat',
    'Gowainghat to Bichnakandi Point'
  ];

  List<String> routeSubtitle = [
    'By CNG',
    'By Walking',
    'By CNG',
    'By Boat',
  ];

  List<String> routePrice = [
    '10tk/person',
    '0',
    '120tk/person',
    '200tk/person',
  ];
}

class MapDetails {
  LatLng center = LatLng(24.8997595, 91.8259623);
  List<LatLng> startEndPoint = [
    LatLng(24.8930464, 91.8653932),
    LatLng(25.1720151, 91.8803782)
  ];
  List<String> placename = [
    'Kodomtuli Station',
    'Bichanakandi Point'];
}