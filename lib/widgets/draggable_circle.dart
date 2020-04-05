import 'dart:math';

import 'package:flutter/material.dart';

import '../global.dart';

class DraggableCircle extends StatefulWidget {
  final IconData icon;
  final String name;
  DraggableCircle({Key key, this.icon, this.name}) : super(key: key);
  @override
  _DraggableCircleState createState() => _DraggableCircleState();
}

class _DraggableCircleState extends State<DraggableCircle> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              border: Border.all(width:3, color: CustomColor.lightBlue1, style:BorderStyle.solid)
          ),
          child: Center(child:Text("x", style: TextStyle(color: CustomColor.lightBlue1),))
        ),
    );
  }
}