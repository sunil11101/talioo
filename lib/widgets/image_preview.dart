import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:talio_travel/models/post.dart';

import '../global.dart';

class ImagePreview extends StatefulWidget {
  final Function() notifyParent;

  Post post;
  ImagePreview({Key key, @required this.notifyParent, this.post}) : super(key: key);

  _ImagePreviewState createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {


  String selectedAspectRatio = PostConfig.cameraAspectRatio[1];

  int listIndex = 0;

  @override
  Widget build(BuildContext context) {
    //final PlacesBloc placesBloc = Provider.of<PlacesBloc>(context); // to access place data
    double w = MediaQuery.of(context).size.width;
    double imageHeight = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        Container(
          width: w,
          height: imageHeight,
          child: PageView.builder(
            controller: PageController(
                initialPage: 0
            ),
            scrollDirection: Axis.horizontal,
            itemCount: widget.post.imagesPickedList.length,



            onPageChanged: (index) {
              setState(() {
                listIndex = index;
                print(listIndex);
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return Hero(
                  tag: 'heroFeatured$index',
                  child: AssetThumb(
                    asset: widget.post.imagesPickedList[index],
                    width: w.toInt(),
                    height: imageHeight.toInt(),
                  )
              );
            },
          ),
        ),

        Container(
          width: w,
          height: 30,
          child: Center(
            child:DotsIndicator(
              dotsCount: widget.post.imagesPickedList.length,
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
    );
  }
}
