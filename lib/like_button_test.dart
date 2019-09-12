import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class ButtonTest extends StatefulWidget {
  ButtonTest({Key key}) : super(key: key);

  _ButtonTestState createState() => _ButtonTestState();
}

class _ButtonTestState extends State<ButtonTest> {

  int count = 0;
  String txt = 'rakib';
  
  increment(){
    setState(() {
      count++;
      txt = 'rimi';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RaisedButton(onPressed: 
          () {
            increment();
          },),
          
          SizedBox(height: 30,),
          Text('$count'),
          
          
        ],
      ),
    );
  }
}