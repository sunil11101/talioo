import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:travel_hour/articles.dart';
import 'package:travel_hour/bookmark.dart';
import 'package:travel_hour/home1.dart';

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

  BottomNavigationBar navbar() {
    return BottomNavigationBar(

      iconSize: 25,
      selectedItemColor: Colors.black,
      selectedIconTheme: IconThemeData(color: Colors.black, size: 26),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      unselectedIconTheme: IconThemeData(color: Colors.grey),
      elevation: 3,
      backgroundColor: Colors.white,
      currentIndex: _cIndex,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              LineIcons.home,
            ),
            title: new Text('Home')),
        BottomNavigationBarItem(
            icon: Icon(
              LineIcons.bookmark_o,
            ),
            title: new Text('Bookmark')),
        
        BottomNavigationBarItem(
            icon: Icon(
              LineIcons.list,
            ),
            title: new Text('Articles')),
      ],
      onTap: (index) {
        _incrementTab(index);

        if(index == 0){
          setState(() {
            page = HomePage1();
          });
        }

        if(index == 1){
          setState(() {
            page = BookmarkPage();
          });
        }

        

        if(index == 2){
          setState(() {
            page = ArticlesPage();
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: navbar(),
      body: AnimatedSwitcher(
            transitionBuilder: (Widget child, Animation<double> animation) {
                return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
              },
            duration: Duration(milliseconds: 400),
            child: page,
          )
          );
    
    
  }
}