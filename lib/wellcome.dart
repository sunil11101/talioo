import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_hour/intro.dart';
import 'package:travel_hour/navbar.dart';

class WellComePage extends StatefulWidget {
  WellComePage({Key key}) : super(key: key);

  _WellComePageState createState() => _WellComePageState();
}

class _WellComePageState extends State<WellComePage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.center,
              height: h * 0.38,
              child: Image(
                image: AssetImage('assets/travel4.png'),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Welcome to',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            Text(
              'Travel Hour',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Text(
                'Explore every famous places in Bangladesh with the easiest way',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            Spacer(),
            Container(
                height: 50,
                width: w * 0.70,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[400], width: 1),
                    borderRadius: BorderRadius.circular(25),
                    // color: Colors.blue[500],
                    // boxShadow: <BoxShadow> [
                    //   BoxShadow(
                    //     color: Colors.blue[100],
                    //     blurRadius: 2,
                    //     offset: Offset(5, 5)
                    //   )
                    // ]
                    ),
                child: FlatButton.icon(
                  padding: EdgeInsets.all(5),
                  //color: Colors.purpleAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  icon: Icon(
                    FontAwesomeIcons.google,
                    color: Colors.blueAccent,
                  ),
                  label: Text(
                    'Sign In With Google',
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => IntroPage()));
                  },
                )),
            SizedBox(
              height: h * 0.12,
            )
          ],
        ),
      ),
    );
  }
}
