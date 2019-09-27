import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_hour/wellcome.dart';


void main(){
  
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //systemNavigationBarColor: Colors.blueAccent,
    //systemNavigationBarIconBrightness: Brightness.dark, // navigation bar color
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark // status bar color
  ));
  runApp(MyApp());

  
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Raleway',
        appBarTheme: AppBarTheme(
          color: Colors.grey[50],
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black,),
          brightness: Brightness.light,
          textTheme: TextTheme(title: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 18,fontFamily: 'Raleway')),
          
        )

      ),

      debugShowCheckedModeBanner: false,
      home: WellComePage(),
    );
  }
}