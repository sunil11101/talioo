import 'dart:collection';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:talio_travel/models/img_files.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:talio_travel/utils/flutter_native_image.dart';

import '../global.dart';

class Post {
  List<Asset> imagesPickedList = List<Asset>();
  List<ImgFile> imagesFileList = List<ImgFile>();
  //Map<String, Color> imagesFilterMap = HashMap<String, Color>();
  File mainVideo = null;
  String videoAspectRatio = PostConfig.cameraAspectRatio[1];
  Color videoFilterColor = Colors.white.withOpacity(0.0);
  String imageTakenPath;
  String postTitle;
  String location;
  String videoDesc;
  String travelDate;

  Post();

  //Post({this.imagesPickedList,this.video,this.imageTokenPath, this.postTitle, this.location, this.videoDesc, this.travelDate});

  Future<void> processImagesBytesList() async{
    for(int i=0; i < imagesPickedList.length; i++){
      bool sameImage = false;

      for(int j=0; j< imagesFileList.length; j++){
        if(imagesFileList[j].identifier == imagesPickedList[i].identifier) {
          print("PRINT" + i.toString());
          sameImage = true;
          break;
        }
      }

      if(!sameImage) {
        var imagePath = await FlutterAbsolutePath.getAbsolutePath(imagesPickedList[i].identifier);
        File imageFile = File(imagePath);
        //ByteData imageByteData = await imagesPickedList[i].getByteData(quality: 100);
        //ByteBuffer byteBuffer = imageByteData.buffer;
        //print("AA");
        //Uint8List imageUint8List = byteBuffer.asUint8List(imageByteData.offsetInBytes, imageByteData.lengthInBytes);

        //print("WIDTH" + imagesPickedList[i].originalWidth.toString());
        //Bitmap bitM = await Bitmap.fromHeadful(imagesPickedList[i].originalWidth, imagesPickedList[i].originalHeight, imageUint8List);
        //bitM.buildHeaded();
        //imagesBytesList.add(ImgByte(imagesPickedList[i].identifier, bitM));

        //Img.Image imgToAdjust = Img.decodeImage(imageUint8List);

        //ReceivePort receivePort = new ReceivePort();
        //await Isolate.spawn(decode, new DecodeParam(imageUint8List, receivePort.sendPort));
        //Img.Image imgToAdjust = await receivePort.first;
        //File f = await FlutterNativeImage.adjustBrightness(imagePath, 100);
        //FileImage fileImg = FileImage(imageFile);
        Image img = Image.file(imageFile, gaplessPlayback: true, fit: BoxFit.cover);
        imagesFileList.add(ImgFile(imagesPickedList[i].identifier, img, imagePath));
        //imagesFileList.add(ImgByte(imagesPickedList[i].identifier, imageFile, imagePath));
      }
    }
  }

/*
  List<Asset> getImagesPickedList(){
    return imagesPickedList;
  }

  void setImagesPickedList(List<Asset> imagesPickedList){
    this.imagesPickedList = imagesPickedList;
  }
  File getMainVideo(){
    return mainVideo;
  }

  void setMainVideo(File mainVideo){
    this.mainVideo = mainVideo;
  }

  String getVideoAspect(){
    return videoAspect;
  }

  void setVideoAspect(String videoAspect){
    this.videoAspect = videoAspect;
  }

  String getImageTokenPath(){
    return imageTokenPath;
  }

  void setImageTokenPath(String imageTokenPath){
    this.imageTokenPath = imageTokenPath;
  }

  String getPostTitle(){
    return postTitle;
  }

  void setPostTitle(String postTitle){
    this.postTitle = postTitle;
  }
  String getLocation(){
    return location;
  }

  void setLocation(String location){
    this.location = location;
  }
  String getVideoDesc(){
    return videoDesc;
  }

  void setVideoDesc(String videoDesc){
    this.videoDesc = videoDesc;
  }

 */
}