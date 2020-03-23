import 'dart:math';

import 'package:flutter/material.dart';

class CircleIcon extends StatefulWidget {
  final IconData icon;
  final String name;
  CircleIcon({Key key, this.icon, this.name}) : super(key: key);
  @override
  _CircleIconState createState() => _CircleIconState();
}

class _CircleIconState extends State<CircleIcon> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(width: 2, color: Colors.black)),
            child: Icon(widget.icon),
          ),
          Text(widget.name),
        ]
    );
  }
}