import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_hour/pages/wellcome.dart';
import 'package:travel_hour/widgets/navbar.dart';

void main() {
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //     //systemNavigationBarColor: Colors.blueAccent,
  //     //systemNavigationBarIconBrightness: Brightness.dark, // navigation bar color
  //     //statusBarColor: Colors.transparent,
  //     //statusBarIconBrightness: Brightness.dark // status bar color
  //     ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int x = 0;

  //checking which page open first
  _checkPage() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    int _x = sp.getInt('x') ?? 0;
    setState(() {
      x = _x;
    });
  }

  @override
  void initState() {
    _checkPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Raleway',
          appBarTheme: AppBarTheme(
            color: Colors.grey[50],
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            brightness: Brightness.light,
            textTheme: TextTheme(
                title: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    fontFamily: 'Raleway'
                    )),
          )),
      debugShowCheckedModeBanner: false,
      home: x == 0 ? WellComePage() : NavBar(),
    );
  }
}
