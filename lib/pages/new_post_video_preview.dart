import 'dart:io';
import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:talio_travel/global.dart';
import 'package:talio_travel/models/post.dart';
import 'package:video_player/video_player.dart';

import 'custom_range_thumb_shape.dart';
import 'new_post_info.dart';

class NewPostVideoPreviewPage extends StatefulWidget{
  Post post;
  final List<String> tabName = ['Filter','Trim'];

  NewPostVideoPreviewPage({Key key, this.post}) : super(key: key);

  @override
  NewPostVideoPreviewPageState createState() => NewPostVideoPreviewPageState();
}

class NewPostVideoPreviewPageState extends State<NewPostVideoPreviewPage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  VideoPlayerController _videoPlayerController;
  var gradesRange = RangeValues(0, 100);
  Future<void> _initializeVideoPlayerFuture;
  String outPath;
  bool _isVideoEditor = false;
  bool _isPlayingVideo = false;
  Duration _position;
  Duration _duration;

  @override
  void initState() {
    //_dropdownGender = buildDropdownMenuItems(_genderList);
    //_selectedGender = _dropdownGender[0].value;
    //print(_selectedGender);
    super.initState();

    print("VIDEO");
    _videoPlayerController = VideoPlayerController.file(
      widget.post.mainVideo,
    )..addListener(() {
      final bool isPlaying = _videoPlayerController.value.isPlaying;
      if (isPlaying != _isPlayingVideo) {
        setState(() {
          _isPlayingVideo = isPlaying;
        });
      }
      Timer.run(() {
        this.setState((){
          _position = _videoPlayerController.value.position;
        });
        setState(() {
          _duration = _videoPlayerController.value.duration;
        });
        if(_duration?.compareTo(_position) == 0 || _duration?.compareTo(_position) == -1){
          print("AAAAAAAA" + gradesRange.start.toString());
         setState((){
           _videoPlayerController.pause();
           _videoPlayerController.seekTo(Duration(seconds: gradesRange.start.truncate()));
         });
        }
      });
    });

    _initializeVideoPlayerFuture = _videoPlayerController.initialize().then((_) {
      setState(() {
        gradesRange = RangeValues(
            0, _videoPlayerController.value.duration.inSeconds.toDouble());
      });
      //_videoPlayerController.play();
    });

    outPath = (widget.post.mainVideo.path
        .toString()
        .substring(0, widget.post.mainVideo.path.toString().lastIndexOf('/') + 1)) +
        'flutrim' +
        DateTime.now().millisecondsSinceEpoch.toString() +
        '.mp4';

    _tabController = TabController(
      length: widget.tabName.length,
      vsync: this,
    )..addListener(() {
      switch (_tabController.index) {
        case 0:
          setState(() {
            _isVideoEditor = false;
          });
          break;
        case 1:
          setState(() {
            _isVideoEditor = true;
          });
          break;
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  String durationFormatter(Duration dur) {
    return dur.toString().substring(
        0, _videoPlayerController.value.position.toString().indexOf('.'));
  }

  void _saveVideo() async {
    String path = outPath;
    GallerySaver.saveVideo(path).then((bool success) {
      setState(() {
        widget.post.mainVideo = File(path);
        print('Video is saved');
        //progress = false;
        //finishedDialog(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    double videoHeight = MediaQuery.of(context).size.width;


    if(widget.post.videoAspectRatio == PostConfig.cameraAspectRatio[0]){
      videoHeight = w;
    }else if(widget.post.videoAspectRatio == PostConfig.cameraAspectRatio[1]){
      videoHeight = w * 16 / 9;
    }

    print("VIDEO_HEIGHT" + videoHeight.toString());

    return new Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            child: Text("Next"),
            onPressed: (){
              _saveVideo();
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
                child: Container(
                  width: w,
                  height: videoHeight,
                  child: ClipRect(
                    child: OverflowBox(
                      alignment: Alignment.center,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Container(
                          width: w,
                          height: w / _videoPlayerController.value.aspectRatio,
                          child: FutureBuilder(
                            future: _initializeVideoPlayerFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.done) {
                                // If the VideoPlayerController has finished initialization, use
                                // the data it provides to limit the aspect ratio of the VideoPlayer.
                                return Stack(children: <Widget>[
                                  AspectRatio(
                                    aspectRatio: _videoPlayerController.value.aspectRatio,
                                    // Use the VideoPlayer widget to display the video.
                                    child: VideoPlayer(_videoPlayerController),
                                  ),
                                  BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                                    child: new Container(
                                      decoration: new BoxDecoration(
                                          color: widget.post.videoFilterColor),
                                    ),
                                  ),
                                  Positioned(
                                    left: 15,
                                    bottom: 15,
                                    child: Container(
                                      color: Colors.grey,
                                      width: 90,
                                      height: 23,
                                      padding: EdgeInsets.all(0.0),
                                      child: Text(
                                        durationFormatter(_position),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 15,
                                    top: 15,
                                    child: Row(
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              widget.post.videoAspectRatio = PostConfig.cameraAspectRatio[0];
                                              print(widget.post.videoAspectRatio);
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child:Icon(Icons.filter_1, color: Colors.white),
                                          ),
                                        ),GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              widget.post.videoAspectRatio = PostConfig.cameraAspectRatio[1];
                                              print(widget.post.videoAspectRatio);
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Icon(Icons.title, color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                                );
                              } else {
                                // If the VideoPlayerController is still initializing, show a
                                // loading spinner.
                                return Center(child: CircularProgressIndicator());
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: w,
            height: 120,
            child:
            TabBarView(
              physics: NeverScrollableScrollPhysics(),
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
                                tag: 'videoFilter$index',
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
                              widget.post.videoFilterColor =  PostConfig.imageFilter[index].color;
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
                  alignment: Alignment(0.0, 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                  child: SliderTheme(
                        data: SliderThemeData(
                          trackHeight: 20,
                          rangeThumbShape: CustomRangeThumbShape(),
                          overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 5),
                        ),
                        child: RangeSlider(
                          min: 0,
                          max: _videoPlayerController.value.duration.inSeconds.toDouble(),
                          activeColor: Colors.blue,
                          inactiveColor: Colors.grey,
                          values: gradesRange,
                          onChangeStart: (RangeValues value) {
                            setState(() {
                              _videoPlayerController.play();
                            });
                          },
                          onChangeEnd: (RangeValues value) {
                            setState(() {
                              _videoPlayerController.pause();
                            });
                          },
                          onChanged: (RangeValues value) {
                            setState(() {
                              if (value.end - value.start >= 2) {
                                if (value.start != gradesRange.start) {
                                  _videoPlayerController.seekTo(Duration(
                                      seconds: value.start.truncate()));
                                }
                                if (value.end != gradesRange.end) {
                                  _videoPlayerController.seekTo(
                                      Duration(seconds: value.end.truncate()));
                                }
                                gradesRange = value;
                                /*timeBoxControllerStart.text = durationFormatter(
                                new Duration(
                                    seconds: gradesRange.start.truncate()));
                            timeBoxControllerEnd.text = durationFormatter(
                                new Duration(
                                    seconds: gradesRange.end.truncate()));*/
                              } else {
                                if (gradesRange.start == value.start) {
                                  gradesRange = RangeValues(
                                      gradesRange.start, gradesRange.start + 2);
                                } else {
                                  gradesRange = RangeValues(
                                      gradesRange.end - 2, gradesRange.end);
                                }
                              }
                              //gradesRange = value;
                            });
                          },
                        ),
                      ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          setState(() {
                            _isPlayingVideo
                                ? _videoPlayerController.pause()
                                : _videoPlayerController.play();
                          });
                        },
                        //color: Colors.grey[850],
                        child: Icon(
                          _isPlayingVideo
                              ? Icons.pause
                              : Icons.play_arrow,
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
      floatingActionButton: _isVideoEditor ? null : FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown
          setState(() {
            // If the video is playing, pause it.
            if (_isPlayingVideo) {
              _videoPlayerController.pause();
            } else {
              // If the video is paused, play it.
              _videoPlayerController.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _isPlayingVideo ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

}