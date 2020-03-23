import 'dart:collection';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:talio_travel/models/img_bytes.dart';
import 'package:image/image.dart' as Img;
import 'package:bitmap/bitmap.dart';

class Post {
  List<Asset> imagesPickedList = List<Asset>();
  List<ImgByte> imagesBytesList = List<ImgByte>();
  //Map<String, Color> imagesFilterMap = HashMap<String, Color>();
  File mainVideo = null;
  String videoAspect;
  String imageTakenPath;
  String postTitle;
  String location;
  String videoDesc;
  DateTime travelDate;

  Post();

  //Post({this.imagesPickedList,this.video,this.imageTokenPath, this.postTitle, this.location, this.videoDesc, this.travelDate});

  Future<void> processImagesBytesList() async{
    for(int i=0; i < imagesPickedList.length; i++){
      print("PRINT" + i.toString());
      bool sameImage = false;

      for(int i=0; i< imagesPickedList.length; i++){
        if(imagesPickedList[i].identifier != imagesPickedList[i].identifier) {
          sameImage = true;
          break;
        }
      }

      if(!sameImage) {
        ByteData imageByteData = await imagesPickedList[i].getByteData(quality: 100);
        ByteBuffer byteBuffer = imageByteData.buffer;
        print("AA");
        Uint8List imageUint8List = byteBuffer.asUint8List(imageByteData.offsetInBytes, imageByteData.lengthInBytes);

        //print("WIDTH" + imagesPickedList[i].originalWidth.toString());
        //Bitmap bitM = await Bitmap.fromHeadful(imagesPickedList[i].originalWidth, imagesPickedList[i].originalHeight, imageUint8List);
        //bitM.buildHeaded();
        //imagesBytesList.add(ImgByte(imagesPickedList[i].identifier, bitM));
        print("BB");
        Img.Image imgToAdjust = Img.decodeImage(imageUint8List);
        print("CC");
        //ReceivePort receivePort = new ReceivePort();
        //await Isolate.spawn(decode, new DecodeParam(imageUint8List, receivePort.sendPort));
        //Img.Image imgToAdjust = await receivePort.first;
        imagesBytesList.add(ImgByte(imagesPickedList[i].identifier, imgToAdjust));
      }
    }
  }

  static void decode(DecodeParam param) {
    Img.Image image = Img.decodeImage(param.file);
    param.sendPort.send(image);
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

class DecodeParam {
  final Uint8List file;
  final SendPort sendPort;
  DecodeParam(this.file, this.sendPort);
}