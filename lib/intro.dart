import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:travel_hour/navbar.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {

  

    

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            height: h * 0.91,
            child: Carousel(
              dotVerticalPadding: h * 0.16,
              dotColor: Colors.grey,
              dotIncreasedColor: Colors.blueAccent,
              autoplay: false,
              dotBgColor: Colors.transparent,
              
              
              images: [

                Page1(),
                Page2(),
                Page3()
                
              ],
            ),
          ),
          Spacer(),
          Container(
            height: 60,
            width: w,
            padding: EdgeInsets.all(0),
            alignment: Alignment.centerRight,
            //color: Colors.blueAccent,
            child: FlatButton(
              child: Text('Skip',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color: Colors.grey),), 
              onPressed: () {
                Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NavBarPage()));
              },),
          )
        ],
      ),
      
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
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
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500,color: Colors.grey[500]),
              ),
            ),
        ],
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
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
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500,color: Colors.grey[500]),
              ),
            ),
        ],
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
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
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500,color: Colors.grey[500]),
              ),
            ),

            SizedBox(height: h * 0.17,),
            Container(
              height: 45,
              width: w * 0.70,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(25),
                boxShadow: <BoxShadow> [
                  BoxShadow(
                    blurRadius: 2,
                    offset: Offset(3, 3),
                    color: Colors.blue[100]
                  )
                ]
              ),
              child: FlatButton(
                
                
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)
                ),
                child: Text('Get Started',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),), onPressed: () {
                  Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NavBarPage()));
                },),
            )
        ],
      ),
    );
  }
}