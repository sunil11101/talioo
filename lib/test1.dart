

import 'package:flutter/material.dart';


class TestPage1 extends StatefulWidget {
  TestPage1({Key key}) : super(key: key);

  _TestPage1State createState() => _TestPage1State();
}

class _TestPage1State extends State<TestPage1> {

  List initialdata = ['rakib','bhuiyan','tonmoy','rimi','ok','iiikkkk'] ;

  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: StreamBuilder(
        
        initialData: initialdata,
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Center(child: Text('no data'),);
          }

          
          
          List data = snapshot.data;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Icon(Icons.bookmark),
              title: Text(data[index]),
            );
           },
          );

        },

      )
    );


}

}