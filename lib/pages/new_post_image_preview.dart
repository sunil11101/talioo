import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:talio_travel/global.dart';
import 'package:talio_travel/models/img_files.dart';
import 'package:talio_travel/models/post.dart';
import 'package:talio_travel/widgets/circle_icon.dart';
import 'package:talio_travel/utils/flutter_native_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:talio_travel/widgets/draggable_circle.dart';
import 'new_post_info.dart';

class NewPostImagePreviewPage extends StatefulWidget{
  Post post;
  final List<String> tabName = ['Filter','Edit'];

  NewPostImagePreviewPage({Key key, this.post}) : super(key: key);

  @override
  NewPostImagePreviewPageState createState() => NewPostImagePreviewPageState();
}

class NewPostImagePreviewPageState extends State<NewPostImagePreviewPage> with SingleTickerProviderStateMixin {
  ImageRefresher _imageRefresher;
  TabController _tabController;
  int listIndex = 0;
  String imageAspectRatio = PostConfig.cameraAspectRatio[1];
  bool showSlider = false;
  String imageEditType = "";
  double sliderMin = 0;
  double sliderMax = 0;
  double sliderValue = 0;
  Offset _currentOffset = Offset(100,100);

  @override
  void initState() {
    super.initState();
    _imageRefresher = ImageRefresher(imageFile: widget.post.imagesFileList);

    _tabController = TabController(
      length: widget.tabName.length,
      vsync: this,
    );
  }

  @override
  void didChangeDependencies(){
    //precacheImage(widget.post.imagesFileList[listIndex].image, context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageRefresher.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if(imageEditType == PostConfig.imageEditType.keys.elementAt(1)){
      sliderMin = -70;
      sliderMax = 70;
      sliderValue = widget.post.imagesFileList[listIndex].brightness;
    }else if(imageEditType == PostConfig.imageEditType.keys.elementAt(2)){
      sliderMin = -50;
      sliderMax = 50;
      sliderValue = widget.post.imagesFileList[listIndex].contrast;
    }else{
      sliderMin = -50;
      sliderMax = 50;
      sliderValue = widget.post.imagesFileList[listIndex].saturation;
    }

    final w = MediaQuery.of(context).size.width;
    double imageHeight = MediaQuery.of(context).size.width;

    if(imageAspectRatio == PostConfig.cameraAspectRatio[0]){
      imageHeight = w;
    }else if(imageAspectRatio == PostConfig.cameraAspectRatio[1]){
      imageHeight = w * 16 / 9;
    }

    return new Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            child: Text("Next"),
            onPressed: (){
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NewPostInfoPage(
                            post: widget.post
                        ),
                  ),
                  ModalRoute.withName('Home')
              );
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.black,
              child: FittedBox(
                fit: BoxFit.contain,
                alignment: Alignment.center,
                child: Stack(
                  children: <Widget>[
                    Container(
                        width: w,
                        height: imageHeight,
                        child: StreamBuilder(
                            stream: _imageRefresher.imageRefreshStream,
                            initialData: widget.post.imagesFileList,
                            builder: (context, snap) {
                              return PageView.builder(
                                controller: PageController(
                                    initialPage: 0
                                ),
                                scrollDirection: Axis.horizontal,
                                itemCount: snap.data.length,

                                onPageChanged: (index) {
                                  setState(() {
                                    listIndex = index;
                                  });
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  return Hero(
                                      tag: 'heroFeatured$index',
                                      child: Container(
                                        child: Stack(
                                          alignment: AlignmentDirectional.center,
                                            children: <Widget>[
                                              snap.data[index].image,
                                              BackdropFilter(
                                                filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                                                child: new Container(
                                                  decoration: new BoxDecoration(
                                                      color: snap.data[index].filterColor),
                                                ),
                                              ),
                                              Positioned(
                                                left: _currentOffset.dx,
                                                top: _currentOffset.dy,
                                                child:Draggable(
                                                child: DraggableCircle(),
                                                feedback: DraggableCircle(),
                                                childWhenDragging: Container(),
                                                  onDraggableCanceled: (velocity, offset){
                                                    setState(() {
                                                      _currentOffset = offset;
                                                    });
                                                  },
                                              ),
                                              ),
                                              /*decoration: new BoxDecoration(
                                        image: new DecorationImage(
                                            fit: BoxFit.cover,
                                            image: snap.data[index].image
                                          //image: new MemoryImage(Img.encodeJpg(widget.post.imagesBytesList[index].image))
                                            //image: widget.post.imagesFileList[index].image
                                        ),
                                      ),
                                      child: new BackdropFilter(
                                        filter: new ImageFilter.blur(
                                            sigmaX: widget.post.imagesFileList[index].blurSigmaX,
                                            sigmaY: widget.post.imagesFileList[index].blurSigmaY),
                                        child: new Container(
                                          decoration: new BoxDecoration(
                                              color: widget.post.imagesFileList[index].filterColor),
                                        ),
                                      ),
                                      */
                                            ]
                                        ),
                                      )
                                  );
                                },
                              );
                            }
                        )
                    ),
                    Container(
                      width: w,
                      height: imageHeight,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: DotsIndicator(
                          dotsCount: widget.post.imagesFileList.length,
                          position: listIndex.toDouble(),                                       // showing dots animation
                          decorator: DotsDecorator(
                            size: const Size.square(8.0),
                            activeSize: const Size(16.0, 8.0),
                            activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: w,
            height: 120,
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                Container(
                  height: 120,
                  width: w,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: PostConfig.imageFilter.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: InkWell(
                          child: Stack(
                            children: <Widget>[
                              Hero(
                                tag: 'imageFilter$index',
                                child: Container(
                                  height: 120,
                                  width: w * 0.35,
                                  child: Icon(Icons.title),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              widget.post.imagesFileList[listIndex].filterColor =  PostConfig.imageFilter[index].color;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: 120,
                  width: w,
                  child: Column(
                    children: <Widget>[
                      !showSlider? Container() : Column(
                          children: <Widget>[
                            Slider(
                              label: imageEditType,
                              min: sliderMin,
                              max: sliderMax,
                              value: sliderValue,
                              onChanged: (value) {
                                double brightness;
                                double contrast;
                                double saturation;
                                print(value);
                                if(imageEditType == PostConfig.imageEditType.keys.elementAt(1)){
                                  brightness = value;
                                  contrast = widget.post.imagesFileList[listIndex].contrast;
                                  saturation = widget.post.imagesFileList[listIndex].saturation;

                                  setState(() {
                                    widget.post.imagesFileList[listIndex].brightness = value;
                                  });
                                }if(imageEditType == PostConfig.imageEditType.keys.elementAt(2)){
                                  brightness = widget.post.imagesFileList[listIndex].brightness;
                                  saturation = widget.post.imagesFileList[listIndex].saturation;
                                  contrast = value;

                                  setState(() {
                                    widget.post.imagesFileList[listIndex].contrast = value;
                                  });
                                }else if(imageEditType == PostConfig.imageEditType.keys.elementAt(3)){
                                  brightness = widget.post.imagesFileList[listIndex].brightness;
                                  contrast = widget.post.imagesFileList[listIndex].contrast;
                                  saturation = value;

                                  setState(() {
                                    widget.post.imagesFileList[listIndex].saturation = value;
                                  });
                                }
                                //_imageRefresher.updateImage(widget.post.imagesFileList, listIndex, brightness, contrast, saturation, widget.post.imagesFileList[listIndex].tiltX, widget.post.imagesFileList[listIndex].tiltY, widget.post.imagesFileList[listIndex].tiltRadius, context);
                                //updatePicutre(widget.post.imagesFileList[listIndex].imagePath, widget.post.imagesFileList[listIndex].brightness, value);
                                //dddddd;
                              },
                            ),
                            Center(
                              child: InkWell(
                                child: CircleIcon(icon: Icons.check, name: "Done"),
                                onTap: () {
                                  setState(() {
                                    showSlider = false;
                                     _imageRefresher.updateImage(widget.post.imagesFileList, listIndex, 50.0, 50.0, 50.0, widget.post.imagesFileList[listIndex].tiltX, widget.post.imagesFileList[listIndex].tiltY, 20.0, context);
                                    imageEditType = "";
                                  });
                                },
                              ),
                            ),
                          ]
                      ),
                      showSlider? Container() : Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: PostConfig.imageEditType.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 15, top: 15),
                                child: index ==0 ?
                                InkWell(
                                  child: CircleIcon(icon: PostConfig.imageEditType.values.elementAt(index), name: PostConfig.imageEditType.keys.elementAt(index)),
                                  onTap: () async {
                                      File croppedFile = await ImageCropper.cropImage(
                                          sourcePath: widget.post.imagesFileList[listIndex].imagePath,
                                          aspectRatioPresets: [
                                            CropAspectRatioPreset.original,
                                            CropAspectRatioPreset.square,
                                            CropAspectRatioPreset.ratio16x9
                                          ],
                                          androidUiSettings: AndroidUiSettings(
                                            toolbarTitle: "Image Adjust",
                                            cropFrameColor: CustomColor.lightBlue1,
                                              activeControlsWidgetColor: CustomColor.lightBlue1,
                                            activeWidgetColor: CustomColor.lightBlue1,
                                            initAspectRatio: CropAspectRatioPreset.original,
                                            lockAspectRatio: false
                                          ),
                                          iosUiSettings: IOSUiSettings(
                                            minimumAspectRatio: 1.0,
                                          )
                                      );
                                  },
                                )
                                    :
                                InkWell(
                                  child: CircleIcon(icon: PostConfig.imageEditType.values.elementAt(index), name: PostConfig.imageEditType.keys.elementAt(index)),
                                  onTap: () {
                                    setState(() {
                                      showSlider = true;
                                      imageEditType =
                                          PostConfig.imageEditType.keys
                                              .elementAt(index);
                                    });
                                  },
                                ),
                              );
                            },
                          )
                      ),
                    ],
                  ),
                ),
              ],
            ),

          ),
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.white,
        child: TabBar(
            controller: _tabController,
            indicatorColor: Colors.teal,
            labelColor: Colors.teal,
            unselectedLabelColor: Colors.black54,
            tabs: <Widget>[
              Tab(text: widget.tabName[0]),
              Tab(text: widget.tabName[1]),
            ]),
      ),
    );
  }
}

class ImageRefresher {
  StreamController<List<ImgFile>> _controller;
  final List<ImgFile> imageFile;

  ImageRefresher({this.imageFile}){
    _controller = StreamController();
  }

  Stream<List<ImgFile>> get imageRefreshStream => _controller.stream;


  void updateImage(List<ImgFile> imgFileList, int listIdx, double brightness, double contrast, double saturation, double tiltX, double tiltY, double tiltRadius, context)  async{
    print("BRI"+tiltRadius.toString());
    print("SAT"+tiltY.toString());
    File f = await FlutterNativeImage.adjustBrightness(imgFileList[listIdx].imagePath, brightness, contrast, saturation, 300, 300, tiltRadius);
    FileImage fileImg = FileImage(f);
    Image img = Image.file(f, gaplessPlayback: true, fit: BoxFit.cover,);
    imgFileList[listIdx].image = img;

    //await precacheImage(imgFileList[listIdx].image, context);
    _controller.sink.add(imgFileList);
  }

  dispose() {
    _controller.close();
  }

}