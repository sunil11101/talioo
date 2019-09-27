import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travel_hour/variables.dart';



class BookmarkPage extends StatefulWidget {
  BookmarkPage({Key key}) : super(key: key);

  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  Widget build(BuildContext context) {
    
    
    return DefaultTabController(

      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          //leading: Icon(LineIcons.bookmark),
          titleSpacing: 10,
          backgroundColor: Colors.white,
          elevation: 1,
          title: Text('Bookmarked Items'),
          textTheme: TextTheme(
            title: TextStyle(color: Colors.black,fontSize: 17,fontFamily: 'Raleway', fontWeight: FontWeight.w500)
          ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.mic,color: Colors.black,), onPressed: () {},)
          ],
          bottom: TabBar(
            labelColor: Colors.black,
            labelStyle: textStyleBold,
            
            
            unselectedLabelColor: Colors.grey,
            indicatorWeight: 2,
            indicatorColor: Colors.grey,
            
            indicatorSize: TabBarIndicatorSize.tab,

            
            tabs: <Widget>[
              
              Tab(
                
                text: 'Places',),
              
              Tab(
                text: 'Articles',)
              
            ],
          ),
        ),

        body: TabBarView(
          children: <Widget>[
            Center(child: FlatButton.icon(icon: Icon(Icons.bookmark), label: Text('Places',style: textStyleBold,), onPressed: () {},)),
            Center(child: Text('Articles',style: textStyleBold,)),

          ],
        ),
      ),
    );
  }
}