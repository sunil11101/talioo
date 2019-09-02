import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travel_hour/variables.dart';

class TravelGuide extends StatefulWidget {
  TravelGuide({Key key}) : super(key: key);

  _TravelGuideState createState() => _TravelGuideState();
}

class _TravelGuideState extends State<TravelGuide> {

  List colorList = [Colors.indigo, Colors.purpleAccent, Colors.orangeAccent, 
    Colors.pinkAccent
  
  ];

  

  List iconList = [
    LineIcons.bus,
    LineIcons.train,
    LineIcons.car,
    LineIcons.dollar,
  ];

  

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
      height: h,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 10),
        child: new Column(
          children: <Widget>[
            Container(
              height: 65,
              child: Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(LineIcons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  
                  SizedBox(
                    width: 20,
                  ),
                  // Text(
                  //   'Tour Guides',
                  //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  // ),

                  
                ],
              ),
            ),

            Container(
              height: 65,
              alignment: Alignment.center,
              color: Colors.greenAccent,
              
              child: Text('Kodomtuli Station to Amborkhana Point',textAlign: TextAlign.center,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
            ),

            SizedBox(height: 15,),
              
            Expanded(
                      child: ListView.separated(
                          //physics: NeverScrollableScrollPhysics(),
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            contentPadding: EdgeInsets.all(0),
                            isThreeLine: true,
                            leading: CircleAvatar(
                              backgroundColor: (colorList..shuffle()).first,
                              radius: 35,
                              child: Icon((iconList..shuffle()).first,color: Colors.white,size: 28,)),
                            title: Text('Kodomtuli to Amborkhana',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                            subtitle: Text('By CNG \nCNG Price : 20tk/person'),
                            trailing: CircleAvatar(
                              backgroundColor: Colors.grey[300],
                              child: Text('${index+1}',style: TextStyle(color: Colors.grey[600]),),
                            ),

                          );
                         }, separatorBuilder: (BuildContext context, int index) {
                           return Divider(color: Colors.grey[400],);
                         },
                        ),
                      ),
            
                  
          ],
        ),
      ),
    ));
  }
}
