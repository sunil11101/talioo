import 'dart:io';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:talio_travel/models/post.dart';
import 'package:talio_travel/pages/new_post_camera.dart';
import 'package:talio_travel/pages/search.dart';
import 'package:video_player/video_player.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:talio_travel/global.dart';

class NewPostInfoPage extends StatefulWidget{
  Post post;

  NewPostInfoPage(
      {Key key,
        this.post
      })
      : super(key: key);


  @override
  NewPostInfoPageState createState() => NewPostInfoPageState();
}

class NewPostInfoPageState extends State<NewPostInfoPage>{
  VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    print("INNNNNNNNNNNN");
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

    int popCounter = 0;

    AlertDialog discardDialog = AlertDialog(
      title: Text("Discard the post"),
      content: Text("Do you want to discard the post? Leaving this page will discard unsaved content."),
      actions: <Widget>[
        FlatButton(
          child: Text("Cancel"),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text("Discard", style: TextStyle(color: Colors.red)),
          onPressed: () =>
              Navigator.of(context).popUntil((_) => popCounter++ >= 3),
        ),
      ],
    );

    Future<bool> _popToHome(){
      return showDialog(
          context: context,
          builder: (BuildContext context){
            return discardDialog;
          }
      );
    }

    var childButtons = List<UnicornButton>();
    if(widget.post.mainVideo == null) {
      childButtons.add(
          UnicornButton(
            hasLabel: true,
            labelText: "Add Video",
            currentButton: FloatingActionButton(
              heroTag: "addVideo",
              child: Icon(Icons.videocam),
              mini: true,
              backgroundColor: CustomColor.mainBlue,
              onPressed: () {
                _pushToNewPostCamera(widget.post, PostConfig.pageViewTitle[0]);
              },
            ),
          ));
    }
    childButtons.add(
        UnicornButton(
          hasLabel: true,
          labelText: "Add Images",
          currentButton: FloatingActionButton(
            heroTag: "addImages",
            child: Icon(Icons.image),
            mini: true,
            onPressed: (){
              _pushToNewPostCamera(widget.post, PostConfig.pageViewTitle[1]);
            },
          ),
        ));

    const tfPadding = EdgeInsets.all(7.0);


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: new Icon(Icons.clear),
          onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context){
                return discardDialog;
              }
          ),
        ),
        centerTitle: true,
        title: Text("New Post"),
        actions: <Widget>[
          FlatButton(
            child: Text("Next"),
            onPressed: (){},
          )
        ],
      ),
      body: WillPopScope(
        onWillPop: _popToHome,
        child:
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Post Title',
                      contentPadding: tfPadding,
                      prefixIcon: Icon(Icons.title),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Location',
                      contentPadding: tfPadding,
                      prefixIcon: Icon(Icons.place),
                    ),
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SearchPage()));
                    },
                  ),
                ),
              ],
            ),
            widget.post.mainVideo != null?
            IntrinsicHeight(
              child:Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 0.5, color: Colors.blueAccent))
                      ),
                      child: widget.post.mainVideo != null ?
                      AspectRatio(
                        aspectRatio: 1.0,
                        child: VideoPlayer(_videoPlayerController),
                      )
                          :
                      Container(),
                    ),
                  ),
                  Expanded(
                      flex: 6,
                      child: ConstrainedBox(
                        constraints: new BoxConstraints(
                          minHeight: 120,
                          maxHeight: 120,
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          reverse: true,
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              labelText: 'Video Description',
                              contentPadding: tfPadding,
                              prefixIcon: Icon(Icons.description),
                            ),
                          ),
                        ),
                      )
                  ),
                  Expanded(
                      flex: 1,
                      child: Icon(Icons.clear, size: iconSize)
                  )
                ],
              ),
            ) : Container(),
            Expanded(child:  Container(
              width: w,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: List.generate(
                    widget.post.imagesPickedList.length, (index){
                  return Dismissible(
                    child: Container(
                      decoration:
                      new BoxDecoration(
                          border: new Border(
                              bottom: new BorderSide(color: Theme.of(context).dividerColor)
                          )
                      ),
                      child:IntrinsicHeight(
                        key: ValueKey(index),
                        child:Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  child: AssetThumb(
                                    asset: widget.post.imagesPickedList[index],
                                    width: 200,
                                    height: 200,
                                  )
                              ),
                            ),
                            Expanded(
                                flex: 6,
                                child: ConstrainedBox(
                                  constraints: new BoxConstraints(
                                    minHeight: 120,
                                    maxHeight: 120,
                                  ),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    reverse: true,
                                    child: TextField(
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      decoration: InputDecoration(
                                          labelText: 'Image Description',
                                          contentPadding: tfPadding,
                                          prefixIcon: Icon(Icons.image_aspect_ratio),
                                          border: InputBorder.none
                                      ),
                                    ),
                                  ),
                                )
                            ),
                            Expanded(
                              flex: 1,
                              child: widget.post.imagesPickedList.length > 1 ? Column(
                                children: <Widget>[
                                  Expanded(
                                    child: index > 0 ? GestureDetector(
                                      child: Icon(Icons.arrow_upward, size: iconSize),
                                      onTap: (){
                                        _updateListItems(index, "UP");
                                      },
                                    ) : Container(),
                                  ),Expanded(
                                    child: index < widget.post.imagesPickedList.length - 1 ? GestureDetector(
                                      child: Icon(Icons.arrow_downward, size: iconSize),
                                      onTap: (){
                                        _updateListItems(index, "DOWN");
                                      },
                                    ) : Container(),
                                  ),
                                ],
                              ) : Container(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onDismissed: (direction) {
                      var item = widget.post.imagesPickedList.elementAt(index);
                      //To delete
                      setState(() {
                        widget.post.imagesPickedList.removeAt(index);
                      });
                      //To show a snackbar with the UNDO button
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("Item deleted"),
                          action: SnackBarAction(
                              label: "UNDO",
                              onPressed: () {
                                //To undo deletion
                                widget.post.imagesPickedList.insert(index, item);
                              })));
                    },
                  );
                }
                ),
              ),
            ),
            ),
          ],
        ),
      ),
      floatingActionButton: UnicornDialer(
        orientation: UnicornOrientation.VERTICAL,
        parentButton: Icon(Icons.add),
        childButtons: childButtons,
      ),
    );
  }
  void _updateListItems(int index, String direction){
    if(direction == "UP") {
      if(index > 0) {
        final item = widget.post.imagesPickedList[index];
        setState(() {
          widget.post.imagesPickedList.removeAt(index);
          widget.post.imagesPickedList.insert(index - 1, item);
        });
      }
    }else if(direction == "DOWN"){
      if(index < widget.post.imagesPickedList.length - 1){
        final item = widget.post.imagesPickedList[index];
        setState(() {
          widget.post.imagesPickedList.removeAt(index);
          widget.post.imagesPickedList.insert(index + 1, item);
        });
      }
    }
  }

  void _pushToNewPostCamera(Post post, String tab){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            NewPostCameraPage(
                post: post,
                tab:tab
            ),
      ),
    );
  }
}