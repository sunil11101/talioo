import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import 'package:travel_hour/pages/blog.dart';
import 'package:travel_hour/pages/bookmark.dart';
import 'package:travel_hour/pages/home.dart';


class NavBar extends StatefulWidget {
  NavBar({Key key}) : super(key: key);

  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  Widget page = HomePage();
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
      iconSize: 28,
      selectedItemColor: Colors.black,
      selectedIconTheme: IconThemeData(color: Colors.black, size: 28),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedIconTheme: IconThemeData(color: Colors.grey[400]),
      elevation: 50,
      backgroundColor: Colors.white,
      currentIndex: _cIndex,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(left: 20,top: 3),
            child: Icon(
              Icons.explore,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 3.0, left: 20),
            child: Icon(
              FontAwesomeIcons.solidCircle,
              size: 6.0,
              color: dotColor,
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera),
          title: Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: Icon(
              FontAwesomeIcons.solidCircle,
              size: 6.0,
              color: dotColor2,
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(Icons.bookmark),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 3.0, right: 20),
            child: Icon(
              FontAwesomeIcons.solidCircle,
              size: 6.0,
              color: dotColor3,
            ),
          ),
        ),
      ],
      onTap: (index) {
        _incrementTab(index);

        if (index == 0) {
          setState(() {
            page = HomePage();
            dotColor = Colors.black;
            dotColor1 = Colors.white;
            dotColor2 = Colors.white;
            dotColor3 = Colors.white;
          });
        }

        if (index == 1) {
          setState(() {
            page = ArticlesPage();
            dotColor = Colors.white;
            dotColor1 = Colors.white;
            dotColor2 = Colors.black;
            dotColor3 = Colors.white;
          });
        }

        if (index == 2) {
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
      body: page);
  }
}
