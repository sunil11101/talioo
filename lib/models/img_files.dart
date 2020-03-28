import 'dart:typed_data';

import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as Img;

class ImgFile{
  String identifier;
  File imageFile;
  String imagePath;
  String aspectRatio;
  Color filterColor = Colors.white.withOpacity(0.0);
  double blurSigmaX = 0.0;
  double blurSigmaY = 0.0;
  //@param contrast 0..10 1 is default
  // @param brightness -255..255 0 is default
  double contrast = 0;
  double brightness = 0;



  ImgFile(this.identifier, this.imageFile, this.imagePath);
}