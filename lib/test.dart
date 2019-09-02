
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';



class TestPage extends StatefulWidget {
  TestPage({Key key}) : super(key: key);

  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text('Test'),
            onPressed: () {
              _pressed();
            },
          )
        ],
      ),
    );
  }

  void _pressed() {
    DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
    databaseReference.child('test01').set({
      'name': 'rakib10',
      'email': 'rakib2051@gmail.com'
      
      });
  }
}