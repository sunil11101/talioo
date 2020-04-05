import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:talio_travel/models/post.dart';
import 'package:video_player/video_player.dart';

class NewPostPreviewPage extends StatefulWidget{
  Post post;

  NewPostPreviewPage(
      {Key key,
        this.post
      })
      : super(key: key);


  @override
  NewPostPreviewPageState createState() => NewPostPreviewPageState();
}

class NewPostPreviewPageState extends State<NewPostPreviewPage>{
  VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    if(widget.post.mainVideo != null) {
      setState(() {
        _videoPlayerController = VideoPlayerController.file(widget.post.mainVideo)..initialize();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    final iconSize = 18.0;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("New Post Preview"),
        actions: <Widget>[
          FlatButton(
            child: Text("Done"),
            onPressed: (){
              /*Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      NewPostCameraPage(
                          post: post,
                          tab:tab
                      ),
                ),
              );*/
            },
          )
        ],
      ),
      body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Text(
              widget.post.postTitle
          ),
          Row(
            children: <Widget>[
              Text(
                  widget.post.location
              ),
              Text(
                  widget.post.travelDate
              ),
            ],
          ),
          widget.post.mainVideo == null?Container():
          Container(
            width: w,
            height: w,
            child: ClipRect(
              child: OverflowBox(
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Container(
                    width: w,
                    height: w / _videoPlayerController.value.aspectRatio,
                    child: Stack(children: <Widget>[
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
                    ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text(
              widget.post.videoDesc
          ),
        ],
      ),
      ),
    );
  }
}