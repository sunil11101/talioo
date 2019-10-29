import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_hour/blocs/blog_bloc.dart';
import 'package:travel_hour/blocs/places_bloc.dart';
import 'package:travel_hour/pages/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
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
              primarySwatch: Colors.blue,
              fontFamily: 'Raleway',
              appBarTheme: AppBarTheme(
                color: Colors.transparent,
                elevation: 0,
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                brightness:
                    Platform.isAndroid ? Brightness.dark : Brightness.light,
                textTheme: TextTheme(
                    title: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        fontFamily: 'Raleway')),
              )),
          debugShowCheckedModeBanner: false,
          home: SplashPage()),
    );
  }
}
