import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travel_hour/articles.dart';
import 'package:travel_hour/bookmark.dart';
import 'package:travel_hour/home1.dart';
import 'package:travel_hour/placelist1.dart';


class NavBarPage extends StatefulWidget {
  NavBarPage({Key key}) : super(key: key);

  _NavBarPageState createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  
  Widget page = HomePage1();

  int _cIndex = 0;

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }

  Color dotColor = Colors.black;
  Color dotColor1 = Colors.white;
  Color dotColor2 = Colors.white;
  Color dotColor3 = Colors.white;


 


  BottomNavigationBar navbar() {
    return BottomNavigationBar(
      
      iconSize: 26,
      selectedItemColor: Colors.black,
      selectedIconTheme: IconThemeData(color: Colors.black, size: 26),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedIconTheme: IconThemeData(color: Colors.grey),
      elevation: 50,
      backgroundColor: Colors.white,
      currentIndex: _cIndex,
      type: BottomNavigationBarType.fixed,
      items: [
       BottomNavigationBarItem(

            icon: Icon(LineIcons.home),
            title: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Icon(
                FontAwesomeIcons.solidCircle,
                size: 5.0,
                color: dotColor,
              ),
            ),
          ),

          BottomNavigationBarItem(

            icon: Icon(Icons.search),
            title: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Icon(
                FontAwesomeIcons.solidCircle,
                size: 5.0,
                color: dotColor1,
              ),
            ),
          ),

          BottomNavigationBarItem(
            icon: Icon(LineIcons.list_alt),
            title: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Icon(
                FontAwesomeIcons.solidCircle,
                size: 5.0,
                color: dotColor2,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.bookmark),
            title:  Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Icon(
                FontAwesomeIcons.solidCircle,
                size: 5.0,
                color: dotColor3,
              ),
            ),
          ),
          
        
        
      ],
      onTap: (index) {
        _incrementTab(index);

        if(index == 0){
          setState(() {
            page = HomePage1();
            dotColor = Colors.black;
            dotColor1 = Colors.white;
            dotColor2 = Colors.white;
            dotColor3 = Colors.white;
          });
        }

        if(index == 1){
          setState(() {
            page = PlaceListPage1();
            dotColor = Colors.white;
            dotColor1 = Colors.black;
            dotColor2 = Colors.white;
            dotColor3 = Colors.white;

          });
        }

        

        if(index == 2){
          setState(() {
            page = ArticlesPage();
            dotColor = Colors.white;
            dotColor1 = Colors.white;
            dotColor2 = Colors.black;
            dotColor3 = Colors.white;

          });
        }

        if(index == 3){
          setState(() {
            page = BookmarkPage();
            dotColor = Colors.white;
            dotColor1 = Colors.white;
            dotColor2 = Colors.white;
            dotColor3 = Colors.black;

          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: navbar(),
      body: page
  );
    
    
  }
}