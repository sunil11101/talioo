import 'package:flutter/material.dart';
import 'package:travel_hour/test.dart';
import 'package:travel_hour/wellcome.dart';


void main(){
  
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   systemNavigationBarColor: Colors.blueAccent,
  //   systemNavigationBarIconBrightness: Brightness.dark, // navigation bar color
  //   statusBarColor: Colors.white,
  //   statusBarIconBrightness: Brightness.dark // status bar color
  // ));
  runApp(MyApp());

  
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
        fontFamily: 'Raleway',
        appBarTheme: AppBarTheme(
          color: Colors.grey[50],
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black,),
          
          textTheme: TextTheme(title: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 18,fontFamily: 'Raleway')),
          //brightness: Brightness.light
        )

      ),

      debugShowCheckedModeBanner: false,
      home: WellComePage(),
    );
  }
}