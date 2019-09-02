import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AccountPage extends StatefulWidget {
  AccountPage({Key key}) : super(key: key);

  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  String picture = 'assets/user.svg';

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: 
      
      Container(
        height: 400,
        width: w,
        color: Colors.deepOrangeAccent,
        child: Stack(
          children: <Widget>[
            Container(
              height: 300,
              width: w,
              color: Colors.indigo,
              
            ),

            Positioned(
              bottom: 42,
              left: w * 0.36,
              child: Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                  //color: Colors.lightGreen,
                  shape: BoxShape.circle

                ),
                child: SvgPicture.asset(picture),
              ),
            ),

            
          ],
        ),
      )
      
      
      
      
      
      
      
      
      
      
      
      // Stack(
          
      //     //alignment: Alignment.center,
      //     children: <Widget>[
      //       Container(
      //         height: MediaQuery.of(context).size.height * 0.50,
      //         width: MediaQuery.of(context).size.width ,
      //         decoration: BoxDecoration(
      //           color: Colors.transparent
      //         ),

      //         child: Stack(
      //           //alignment: Alignment.center,
      //           children: <Widget>[
      //             Container(
      //               height: MediaQuery.of(context).size.height * 0.35,
      //               color: Colors.blueAccent,
      //             ),

      //       Positioned(
      //         height: 300,
      //         width: 300,
      //         child: SvgPicture.asset(picture),),


      //       Positioned(
      //         bottom: -10,
      //         height: 100,
      //         width: 100,
      //         child: Container(
      //           color: Colors.pinkAccent,
      //         ),
      //       )


      //           ],
      //         ),
              
              
              
      //       ),

            
      //     ],
      //   ),
      
    );
  }
}