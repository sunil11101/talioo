import 'package:flutter/material.dart';

class TestPage1 extends StatefulWidget {
  TestPage1({Key key}) : super(key: key);

  _TestPage1State createState() => _TestPage1State();
}

class _TestPage1State extends State<TestPage1> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 300.0,
              floating: false,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("Collapsing Toolbar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  background: Stack(
                    children: <Widget>[
                    Container(
                      //height: 300,
                      width: w,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage('https://www.c2dh.uni.lu/sites/default/files/styles/full_width/public/field/image/capture.png?itok=REb8jh_H')
                        )
                      ),
                    ),

                    Positioned(
                      top: 35,
                      left: 20,
                      child: CircleAvatar(
                        radius: 25,
                          backgroundColor: Colors.white,
                          child: IconButton(
                          icon: Icon(Icons.close, size: 28, color: Colors.black),
                          onPressed: (){}
                          ,
                        ),
                      ),
                    )
                    ],
                  )
                  
                  
                  ),
            ),
          ];
        },
        body: Container(
          height: h,
          width: w,
          decoration: BoxDecoration(
            color: Colors.white,
            
          ),
          child:  ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.people),
                ),
                title: Text('Rakib Bhuiyan'),
                subtitle: Text('rakib205@gmail.com'),
              );
             },
            ),
          ),
          
      )
    );
  }
}