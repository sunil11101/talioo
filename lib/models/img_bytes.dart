import 'dart:typed_data';

import 'dart:ui';

import 'package:bitmap/bitmap.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as Img;

class ImgByte{
  String identifier;
  //Uint8List imgBytes;
  Img.Image image;
  //Bitmap bitmapImage;
  String aspectRatio;
  Color filterColor = Colors.white.withOpacity(0.0);
  double blurSigmaX = 0.0;
  double blurSigmaY = 0.0;
  double contrast = 0;
  double brightness = 0;



  ImgByte(this.identifier, this.image);
}