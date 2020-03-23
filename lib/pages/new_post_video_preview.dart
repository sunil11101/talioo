import 'package:flutter/material.dart';
import 'package:talio_travel/global.dart';
import 'package:talio_travel/models/post.dart';
import 'package:talio_travel/widgets/image_preview.dart';
import 'package:video_player/video_player.dart';

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
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    //_dropdownGender = buildDropdownMenuItems(_genderList);
    //_selectedGender = _dropdownGender[0].value;
    //print(_selectedGender);
    super.initState();

    print("VIDEO");
    _videoPlayerController = VideoPlayerController.file(
      widget.post.mainVideo,
    );

    _initializeVideoPlayerFuture = _videoPlayerController.initialize();

    _tabController = TabController(
      length: widget.tabName.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final videoHeight = MediaQuery.of(context).size.width;

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
                              return AspectRatio(
                                aspectRatio: _videoPlayerController.value.aspectRatio,
                                // Use the VideoPlayer widget to display the video.
                                child: VideoPlayer(_videoPlayerController),
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
          SizedBox(
            width: w,
            height: 150,
            child:
            TabBarView(
              controller: _tabController,
              children: <Widget>[
                Container(
                  height: 150,
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
                                  height: 200,
                                  width: w * 0.35,
                                  child: Icon(Icons.title),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {

                          },
                        ),
                      );
                    },
                  ),
                ),
                Center(child: Text("Tab two")),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown
          setState(() {
            // If the video is playing, pause it.
            if (_videoPlayerController.value.isPlaying) {
              _videoPlayerController.pause();
            } else {
              // If the video is paused, play it.
              _videoPlayerController.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

}