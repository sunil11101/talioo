import 'dart:io';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lamp/lamp.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:talio_travel/models/img_files.dart';
import 'package:talio_travel/models/post.dart';
import 'package:talio_travel/pages/new_post_image_preview.dart';
import 'package:talio_travel/utils/flutter_native_image.dart';


import '../global.dart';
import 'new_post_video_preview.dart';

class NewPostCameraPage extends StatefulWidget{
  //final PageController controller;
  final double iconHeight = 30;
  final PageController bottomPageController = PageController(viewportFraction: .2);

  Post post;
  String tab;
  NewPostCameraPage({Key key, this.post, this.tab}) : super(key: key);

  @override
  NewPostCameraPageState createState() => NewPostCameraPageState();
}

class NewPostCameraPageState extends State<NewPostCameraPage>{
  List<CameraDescription> cameras;
  bool cameraFlashOn = false;
  CameraController _cameraController;
  Future<void> _controllerInizializer;
  double cameraHorizontalPosition = 0;

  List<String> pageViewList = PostConfig.pageViewTitle;
  String imageAspectRatio = PostConfig.cameraAspectRatio[1];

  List<Asset> imagesPickedList = List<Asset>();
  String videoRecordedPath;

  bool isVideoPage = true;
  bool isVideoRecording = false;

  bool isLoading = false;



  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  Future<CameraDescription> getCamera() async {
    cameras = await availableCameras();
    return cameras.first;
  }

  @override
  void initState() {
    super.initState();

    if(widget.tab != null){
      pageViewList = [widget.tab];
      if(widget.tab == PostConfig.pageViewTitle[1])
        isVideoPage= false;
    }

    if(widget.post.imagesPickedList.length > 0){
      imagesPickedList = widget.post.imagesPickedList;
    }

    getCamera().then((camera) {
      if (camera == null) return;
      setState(() {
        _cameraController = CameraController(
          camera,
          ResolutionPreset.high,
        );
        _controllerInizializer = _cameraController.initialize();
        /*_controllerInizializer.whenComplete(() {
          setState(() {
            cameraHorizontalPosition = -(MediaQuery.of(context).size.width*_cameraController.value.aspectRatio)/2;
          });
        });*/
      });
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final size = MediaQuery.of(context).size;
    double cameraWidth = MediaQuery.of(context).size.width;
    double cameraHeight = MediaQuery.of(context).size.width;

    if(isVideoPage && widget.post.videoAspectRatio == PostConfig.cameraAspectRatio[0]){
      cameraHeight = cameraWidth;
    }else if(isVideoPage && widget.post.videoAspectRatio == PostConfig.cameraAspectRatio[1]){
      cameraHeight = cameraWidth * 16 / 9;
    }
    if(!isVideoPage && imageAspectRatio == PostConfig.cameraAspectRatio[0]){
      cameraHeight = cameraWidth;
    }else if(!isVideoPage && imageAspectRatio == PostConfig.cameraAspectRatio[1]){
      cameraHeight = cameraWidth * 16 / 9;
    }

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          /* trying to preserve aspect ratio */
          //left: cameraHorizontalPosition,
          //right: cameraHorizontalPosition,
          child: FutureBuilder(
            future: _controllerInizializer,
            builder: (context, snapshot) {
              if (!isLoading && snapshot.connectionState == ConnectionState.done) {
                return Container(
                  width: cameraWidth,
                  height: cameraHeight,
                  child: ClipRect(
                    child: OverflowBox(
                      alignment: Alignment.center,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Container(
                          width: cameraWidth,
                          height:
                          cameraWidth / _cameraController.value.aspectRatio,
                          child: CameraPreview(_cameraController), // this is my CameraPreview
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
        Positioned.fill(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: AnimatedOpacity(
                opacity: isVideoRecording ? 0 : 1,
                duration: Duration(milliseconds: 500),
                child: new IconButton(
                            icon: new Icon(Icons.clear, color: Colors.white),
                            onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              actions: <Widget>[
                GestureDetector(
                  onTap: () {
                    if(isVideoPage){
                      setState(() {
                        widget.post.videoAspectRatio = PostConfig.cameraAspectRatio[0];
                      });
                    }else{

                      setState(() {
                        imageAspectRatio = PostConfig.cameraAspectRatio[0];
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child:Icon(Icons.filter_1, color: Colors.white),
                  ),
                ),GestureDetector(
                  onTap: () {
                    if(isVideoPage){
                      setState(() {
                        widget.post.videoAspectRatio = PostConfig.cameraAspectRatio[1];
                      });
                    }else{

                      setState(() {
                        imageAspectRatio = PostConfig.cameraAspectRatio[1];
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Icon(Icons.title, color: Colors.white),
                  ),
                ),
              ],
            ),
            body: Container(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    bottom: 50,
                    right: 40,
                    left: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                      AnimatedOpacity(
                        opacity: isVideoRecording ? 0 : 1,
                          duration: Duration(milliseconds: 500),
                          child:GestureDetector(
                            child: Container(
                              height: widget.iconHeight,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: ClipRRect(
                                child: Image(
                                  image: AssetImage('assets/images/travel1.png'),
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                            ),
                            onTap: (){
                              isVideoPage ?
                              _loadVideo() .then((File videoPicked) {
                                if(videoPicked != null) {
                                  widget.post.mainVideo = videoPicked;
                                  _pushToNewPostInfo();
                                }
                              })
                                  :
                              _loadAssets().then((_) async{
                                if(widget.post.imagesPickedList.length > 0) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await widget.post.processImagesBytesList();
                                  setState(() {
                                    isLoading = false;
                                  });
                                  _pushToNewPostInfo();
                                }
                              });
                            }
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: isVideoRecording ? 0 : 1,
                          duration: Duration(milliseconds: 500),
                          child:GestureDetector(
                              onTap: () {
                                setState(() {
                                  _switchFlash();
                                });
                              },
                              child: Container(
                                height: widget.iconHeight,
                                child: Icon(
                                  Icons.flash_on,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if(isVideoPage){
                              if(!isVideoRecording) {
                                _startVideoRecording().then((String filePath) {
                                    print('Saving video to $filePath');
                                  });
                              }else{
                                  _stopVideoRecording().then((_) {
                                    print('Video recorded to: $videoRecordedPath');
                                    setState(() {
                                      File videoRecorded = File(videoRecordedPath);
                                      widget.post.mainVideo = videoRecorded;
                                      _pushToNewPostInfo();
                                    });
                                  });
                              }
                            }else {
                              _takePicture().then((String imageTakenPath) async{
                                print('Picture saved to $imageTakenPath');
                                //File f = await FlutterNativeImage.adjustBrightness(imageTakenPath, 100);
                                File imageFile = File(imageTakenPath);
                                Image img = Image.file(imageFile, gaplessPlayback: true, fit: BoxFit.cover);
                                widget.post.imagesFileList.add(ImgFile(null, img, imageTakenPath)) ;
                                _pushToNewPostInfo();
                              });
                            }
                          },
                          child: Container(
                            child: Container(
                              decoration: BoxDecoration(
                                color: isVideoPage && !isVideoRecording ? Colors.red : Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(isVideoRecording ? 10 : 25),
                                ),
                              ),
                            ),
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(35),
                              ),
                              border: Border.all(
                                width: 8,
                                color: Colors.white.withOpacity(.5),
                              ),
                            ),
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: isVideoRecording ? 0 : 1,
                          duration: Duration(milliseconds: 500),
                          child:GestureDetector(
                              onTap: () {
                                setState(() {
                                  _changeCamera();
                                });
                              },
                              child: Container(
                                height: widget.iconHeight,
                                child: Icon(
                                  Icons.cached,
                                  color: Colors.white,
                                )
                              ),
                            ),
                        ),
                        AnimatedOpacity(
                          opacity: isVideoRecording ? 0 : 1,
                          duration: Duration(milliseconds: 500),
                          child: Container(
                              height: widget.iconHeight,
                              child: Icon(
                                Icons.tag_faces,
                                color: Colors.white,
                              ),
                            ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    left: 0,
                    bottom: 10,
                    height: 20,
                    child: AnimatedOpacity(
                      opacity: isVideoRecording ? 0 : 1,
                      duration: Duration(milliseconds: 500),
                      child: PageView.builder(
                        controller: widget.bottomPageController,
                        itemCount: pageViewList.length,
                        onPageChanged: _onPageChanged,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                                widget.bottomPageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
                            },
                            child: Text(
                              pageViewList[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    width: 10,
                    height: 10,
                    child: AnimatedOpacity(
                      opacity: isVideoRecording ? 0 : 1,
                      duration: Duration(milliseconds: 500),
                      child: Icon(
                        Icons.arrow_drop_up,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  void _onPageChanged(int index){
    setState(() {
      if(pageViewList[index] == PostConfig.pageViewTitle[0])
        isVideoPage = true;
      else
        isVideoPage = false;
    });
  }

  Future<String> _takePicture() async {
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/images/new_post';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (_cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await _cameraController.takePicture(filePath);
    } on CameraException catch (e) {
      print("ERROR Code" + e.code + "," + e.description);
      return null;
    }
    return filePath;
  }

  Future<String> _startVideoRecording() async {
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/videos/new_post';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.mp4';

    if (_cameraController.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return null;
    }

    try {
      setState(() {
        isVideoRecording = true;
      });
      videoRecordedPath = filePath;
      await _cameraController.startVideoRecording(filePath);
    } on CameraException catch (e) {
      print("ERROR Code" + e.code + "," + e.description);
      return null;
    }
    return filePath;
  }

  Future<void> _stopVideoRecording() async {
    if (!_cameraController.value.isRecordingVideo) {
      return null;
    }

    try {
      await _cameraController.stopVideoRecording();
      setState(() {
        isVideoRecording = false;
      });
    } on CameraException catch (e) {
      print("ERROR Code" + e.code + "," + e.description);
      return null;
    }

    //await _startVideoPlayer();
  }

  void _changeCamera(){
    if(_cameraController.description.lensDirection == CameraLensDirection.back) {
      _cameraController = CameraController(
        cameras[1],
        ResolutionPreset.high,
      );
    }
    else {
      _cameraController = CameraController(
        cameras[0],
        ResolutionPreset.high,
      );
    }
    _controllerInizializer = _cameraController.initialize();
    _controllerInizializer.whenComplete(() {
      setState(() {
        cameraHorizontalPosition = -(MediaQuery.of(context).size.width*_cameraController.value.aspectRatio)/2;
      });
    });
  }

  void _switchFlash() async{
    if(cameraFlashOn == false){
      cameraFlashOn = true;
      Lamp.turnOn();
    }else{
      cameraFlashOn = false;
      Lamp.turnOff();
    }
  }

  Future<File> _loadVideo() async {
    // This funcion will helps you to pick a Video File
    File video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    return video;
    /*
    _videoPlayerController = VideoPlayerController.file(_video)..initialize().then((_) {
      setState(() { });
      _videoPlayerController.play();
    });
    */
  }

  Future<void> _loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: false,
        selectedAssets: widget.post.imagesPickedList,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Talioo",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    setState(() {
      widget.post.imagesPickedList = resultList;
      print("ERROR:$error");
    });
  }

  void _pushToNewPostInfo(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            isVideoPage ? NewPostVideoPreviewPage(post: widget.post):
            NewPostImagePreviewPage(post: widget.post)
      ),
    );
  }
}