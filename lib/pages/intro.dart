import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_hour/widgets/navbar.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  String name;

  _getName() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String _name = sp.getString('userName') ?? 'User';
    setState(() {
      name = _name;
    });
  }

  @override
  void initState() {
    _getName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            height: h * 0.80,
            child: Carousel(
              dotVerticalPadding: h * 0.00,
              dotColor: Colors.grey,
              dotIncreasedColor: Colors.blueAccent,
              autoplay: true,
              dotBgColor: Colors.transparent,
              dotSize: 7,
              images: [page1(), page2(), page3()],
            ),
          ),
          SizedBox(
            height: h * 0.05,
          ),
          Container(
            height: 45,
            width: w * 0.70,
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(25),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      blurRadius: 2,
                      offset: Offset(3, 3),
                      color: Colors.blue[100])
                ]),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: Text(
                'Get Started',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => NavBar()));
              },
            ),
          ),
          SizedBox(
            height: 0.15,
          ),
        ],
      ),
    );
  }

  Widget page1() {
    double h = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Container(
            alignment: Alignment.center,
            height: h * 0.38,
            child: Image(
              image: AssetImage('assets/travel6.png'),
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Hi $name,',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600]),
          ),
          Text(
            'No matter where you are',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              'Access to importent infoemation about your destination before and during your travel',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[500]),
            ),
          ),
        ],
      ),
    );
  }

  Widget page2() {
    double h = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Container(
            alignment: Alignment.center,
            height: h * 0.38,
            child: Image(
              image: AssetImage('assets/travel1.png'),
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Explore Nearby Stuffs',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              'Explore nearby hotels & retaurants near every tourist spots with the most most easiest way',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[500]),
            ),
          ),
        ],
      ),
    );
  }

  Widget page3() {
    //double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Container(
            alignment: Alignment.center,
            height: h * 0.38,
            child: Image(
              image: AssetImage('assets/travel5.png'),
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Travel Guide',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              'Get directions, costs and other travel related stuffs in one place',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[500]),
            ),
          ),
        ],
      ),
    );
  }
}
