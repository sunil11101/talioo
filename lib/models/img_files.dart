import 'dart:typed_data';

import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as Img;

class ImgFile{
  String identifier;
  Image image;
  //FileImage image;
  String imagePath;
  String imageDesc;
  String aspectRatio;
  Color filterColor = Colors.white.withOpacity(0.0);
  double blurSigmaX = 0.0;
  double blurSigmaY = 0.0;
  // @param brightness -255..255 0 is default
  double brightness = 0;
  //@param contrast 0..10 1 is default
  double contrast = 0;
  //@param contrast 0..2 1 is default
  double saturation = 0;
  double tiltX = 500;
  double tiltY = 500;
  double tiltRadius = 100;



  ImgFile(this.identifier, this.image, this.imagePath);
}