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

  @override
  void initState() {
    super.initState();
    _imageRefresher = ImageRefresher(imageFile: widget.post.imagesFileList[0].imageFile);

    _tabController = TabController(
      length: widget.tabName.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _imageRefresher.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
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
                            initialData: widget.post.imagesFileList[0].imageFile,
                            builder: (context, snap) {
                              return PageView.builder(
                                controller: PageController(
                                    initialPage: 0
                                ),
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.post.imagesFileList.length,

                                onPageChanged: (index) {
                                  setState(() {
                                    listIndex = index;
                                    print(listIndex);
                                  });
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  //Uint8List headedBitmap = widget.post.imagesBytesList[index].bitmapImage.buildHeaded();
                                  //File f = new File(widget.post.imagesPickedList[index].identifier);
                                  return Hero(
                                    tag: 'heroFeatured$index',
                                    child: Container(
                                      decoration: new BoxDecoration(
                                        image: new DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(snap.data)
                                          //image: new MemoryImage(Img.encodeJpg(widget.post.imagesBytesList[index].image))
                                          //image: new FileImage(f)
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
                                    ),
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
                      Container(
                        width: w,
                        height: 30,
                        child:Slider(
                          label: 'Brightness',
                          min: -100,
                          max: 100,
                          value: widget.post.imagesFileList[listIndex].brightness,
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              widget.post.imagesFileList[listIndex].brightness = value;
                            });
                            _imageRefresher.updatePicutre(widget.post.imagesFileList[listIndex].imagePath, value);
                            //updatePicutre(widget.post.imagesFileList[listIndex].brightness, value);

                          },
                        ),
                      ),
                      Expanded(
                        child:ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child:
                                InkWell(
                                  child:CircleIcon(icon: Icons.brightness_5, name: "Brightness"),
                                  onTap: () {
                                    setState(() {
                                      //widget.post.imagesBytesList[listIndex].filterColor =  PostConfig.imageFilter[index].color;
                                    });
                                  },
                                )

                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: InkWell(
                                child: CircleIcon(icon: Icons.brightness_6, name: "Contrast"),
                                onTap: () {
                                  setState(() {
                                    //widget.post.imagesBytesList[listIndex].filterColor =  PostConfig.imageFilter[index].color;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
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

  void updatePicutre(double contrast, double brightness)  {
    //widget.post.imagesBytesList[listIndex].image =  Img.contrast(widget.post.imagesBytesList[listIndex].image, brightness);
    setState(() {
      widget.post.imagesFileList[listIndex].brightness = brightness;
      //widget.post.imagesBytesList[listIndex].imgBytes = Img.encodeJpg(widget.post.imagesBytesList[listIndex].image);
    });
    //picutreStream.add(Img.encodeJpg(Img.contrast(widget.post.imagesBytesList[listIndex].image, brightness)));
  }

}

class ImageRefresher {
  StreamController<File> _controller;
  final File imageFile;

  ImageRefresher({this.imageFile}){
    _controller = StreamController();
  }

  Stream<File> get imageRefreshStream => _controller.stream;


  void updatePicutre(String imagePath, double brightness)  async{
    File f = await FlutterNativeImage.adjustBrightness(imagePath, brightness);
    _controller.sink.add(f);
  }

  dispose() {
    _controller.close();
  }

}