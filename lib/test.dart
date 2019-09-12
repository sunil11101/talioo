
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:firebase_auth/firebase_auth.dart';



class TestPage extends StatefulWidget {
  TestPage({Key key}) : super(key: key);

  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  
  
  final FirebaseAuth auth = FirebaseAuth.instance;
  
  GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

  Future<void> _handleSignIn() async {
  try {
    await _googleSignIn.signIn();
  } catch (error) {
    print(error);
  }
}

  Future<void> _handleSignOut () async {
    try{
      await _googleSignIn.signOut();
    }
    catch (error){
      print(error);
    }
  }

  

 
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text('SignIn'),
            onPressed: () {
              _handleSignIn().whenComplete((){
                print('SignIn SuccessFull');

              });
            },
          ),

           RaisedButton(
            child: Text('SignOut'),
            onPressed: () {
              _handleSignOut().whenComplete((){
                print('Signout Successful');
              });
            },
          )
        ],
      ),
    );
  }

  
}