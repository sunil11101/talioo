import 'dart:ui';

import 'package:flutter/material.dart';
import 'models/img_filter.dart';

class PostConfig{
  static List<String> pageViewTitle = ["Video","Images"];
  static List<String> cameraAspectRatio = ["1:1","16:9"];
  static Map<String, IconData> imageEditType = {"Adjust": Icons.crop_rotate,"Brightness": Icons.brightness_5,"Contrast": Icons.brightness_6,"Saturation": Icons.opacity,"Focus": Icons.adjust};
  static List<ImgFilter> imageFilter = [
    ImgFilter("","Filter1", Color.fromRGBO(200, 0, 0, 0.5)),
    ImgFilter("","Filter2", Color.fromRGBO(200, 0, 0, 0.5)),
    ImgFilter("","Filter3", Color.fromRGBO(200, 0, 0, 0.5)),
    ImgFilter("","Filter4", Color.fromRGBO(200, 0, 0, 0.5)),
    ImgFilter("","Filter5", Color.fromRGBO(200, 0, 0, 0.5)),
    ImgFilter("","Filter6", Color.fromRGBO(200, 0, 0, 0.5)),
    ImgFilter("","Filter7", Color.fromRGBO(200, 0, 0, 0.5)),
    ImgFilter("","Filter8", Color.fromRGBO(200, 0, 0, 0.5)),
    ImgFilter("","Filter9", Color.fromRGBO(200, 0, 0, 0.5)),
    ImgFilter("","Filter10", Color.fromRGBO(200, 0, 0, 0.5)),
  ];
}

class CustomColor{
  static const MaterialColor mainBlue = MaterialColor(
    _mainBlueValue,
    <int, Color>{
      50: Color.fromRGBO(78, 114, 184, .1),
      100: Color.fromRGBO(78, 114, 184, .2),
      200: Color.fromRGBO(78, 114, 184, .3),
      300: Color.fromRGBO(78, 114, 184, .4),
      400: Color.fromRGBO(78, 114, 184, .5),
      500: Color.fromRGBO(78, 114, 184, .6),
      600: Color.fromRGBO(78, 114, 184, .7),
      700: Color.fromRGBO(78, 114, 184, .8),
      800: Color.fromRGBO(78, 114, 184, .9),
      900: Color.fromRGBO(78, 114, 184, 1),
    },
  );
  static const int _mainBlueValue = 0xFF4E72B8;

  static const MaterialColor lightBlue1 = MaterialColor(
    _lightBlue1Value,
    <int, Color>{
      50: Color.fromRGBO(177, 223, 222, .1),
      100: Color.fromRGBO(177, 223, 222, .2),
      200: Color.fromRGBO(177, 223, 222, .3),
      300: Color.fromRGBO(177, 223, 222, .4),
      400: Color.fromRGBO(177, 223, 222, .5),
      500: Color.fromRGBO(177, 223, 222, .6),
      600: Color.fromRGBO(177, 223, 222, .7),
      700: Color.fromRGBO(177, 223, 222, .8),
      800: Color.fromRGBO(177, 223, 222, .9),
      900: Color.fromRGBO(177, 223, 222, 1),
    },
  );
  static const int _lightBlue1Value = 0xFFB1DFDE;

  static const MaterialColor lightBlue2 = MaterialColor(
    _lightBlue2Value,
    <int, Color>{
      50: Color.fromRGBO(106, 202, 213, .1),
      100: Color.fromRGBO(106, 202, 213, .2),
      200: Color.fromRGBO(106, 202, 213, .3),
      300: Color.fromRGBO(106, 202, 213, .4),
      400: Color.fromRGBO(106, 202, 213, .5),
      500: Color.fromRGBO(106, 202, 213, .6),
      600: Color.fromRGBO(106, 202, 213, .7),
      700: Color.fromRGBO(106, 202, 213, .8),
      800: Color.fromRGBO(106, 202, 213, .9),
      900: Color.fromRGBO(106, 202, 213, 1),
    },
  );
  static const int _lightBlue2Value = 0xFF6ACAD5;

  static const MaterialColor yellowGreen = MaterialColor(
    _yellowGreenValue,
    <int, Color>{
      50: Color.fromRGBO(200, 211, 169, .1),
      100: Color.fromRGBO(200, 211, 169, .2),
      200: Color.fromRGBO(200, 211, 169, .3),
      300: Color.fromRGBO(200, 211, 169, .4),
      400: Color.fromRGBO(200, 211, 169, .5),
      500: Color.fromRGBO(200, 211, 169, .6),
      600: Color.fromRGBO(200, 211, 169, .7),
      700: Color.fromRGBO(200, 211, 169, .8),
      800: Color.fromRGBO(200, 211, 169, .9),
      900: Color.fromRGBO(200, 211, 169, 1),
    },
  );
  static const int _yellowGreenValue = 0xFFC8D3A9;

  static const MaterialColor brown = MaterialColor(
    _brownValue,
    <int, Color>{
      50: Color.fromRGBO(141, 119, 102, .1),
      100: Color.fromRGBO(141, 119, 102, .2),
      200: Color.fromRGBO(141, 119, 102, .3),
      300: Color.fromRGBO(141, 119, 102, .4),
      400: Color.fromRGBO(141, 119, 102, .5),
      500: Color.fromRGBO(141, 119, 102, .6),
      600: Color.fromRGBO(141, 119, 102, .7),
      700: Color.fromRGBO(141, 119, 102, .8),
      800: Color.fromRGBO(141, 119, 102, .9),
      900: Color.fromRGBO(141, 119, 102, 1),
    },
  );
  static const int _brownValue = 0xFF8D7766;
}