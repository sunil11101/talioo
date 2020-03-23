// Read the documentation first


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:talio_travel/blocs/blog_bloc.dart';
import 'package:talio_travel/blocs/places_bloc.dart';
import 'package:talio_travel/pages/splash.dart';
import 'package:talio_travel/global.dart';

//TODO : setup firebase and Replace <google-services.json> file in the /android/apps directory by your's one.
//TODO : Replace GoogleService-Info.plist file in thr /ios/runner directory and Input your API key in the ios/runner/appDelegate.m file
//TODO : Setup google map for both iOS and Android . Input 'Your API Key' in the android/app/src/main/AndroidManifest.xml path.


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}


//declearing providers and intial screen 
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => PlacesBloc(),
        ),
        ChangeNotifierProvider(
          builder: (context) => BlogBloc(),
        ),
      ],
      child: MaterialApp(
          theme: ThemeData(
              primarySwatch: CustomColor.mainBlue,
              primaryColor: CustomColor.lightBlue1,
              accentColor: CustomColor.yellowGreen,
              //cardColor: CustomColor.lightBlue2,
              dividerColor: Colors.black12,
              fontFamily: 'Raleway',
              appBarTheme: AppBarTheme(
                color: Colors.transparent,
                elevation: 0,
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                brightness: Platform.isAndroid ? Brightness.dark : Brightness.light,
                textTheme: TextTheme(
                    title: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        fontFamily: 'Raleway')),
              )),
          debugShowCheckedModeBanner: false,
          home: SplashPage()
      ),
    );
  }
}
