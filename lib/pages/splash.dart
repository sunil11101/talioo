import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talio_travel/pages/wellcome.dart';
import 'package:talio_travel/widgets/navbar.dart';


// launcher page > a simple rotation animation

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin{

  AnimationController _controller;


  // when animation is completed
  afterSplash() {
    var duration = Duration(milliseconds: 2000);
    return Timer(duration, nextPage);
  }


  // choosing which page to go
  void nextPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => 
          
          x == 0 ? WellComePage() : NavBar(),
        ));
  }

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
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _controller.forward();
    
    
    afterSplash();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: RotationTransition(
              turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
              child: Image(
                image: AssetImage('assets/images/splash.png'),
                height: 120,
                width: 120,
                fit: BoxFit.contain,
              )
            ),
    ));
  }
}
