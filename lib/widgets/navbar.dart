import 'package:path/path.dart' as Path;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talio_travel/models/post.dart';

import 'package:talio_travel/pages/blog.dart';
import 'package:talio_travel/pages/bookmark.dart';
import 'package:talio_travel/pages/home.dart';
import 'package:talio_travel/pages/account.dart';
import 'package:talio_travel/pages/new_post_camera.dart';

class NavBar extends StatefulWidget {
  NavBar({Key key}) : super(key: key);

  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  ScrollController _scrollController = new ScrollController();
  bool isScrollingDown = false;
  bool _showMenu = true;

  String userName, userProfilePic = '';

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
  Color dotColor4 = Colors.white;

  whenBackButtonClicked() {
    SystemNavigator.pop();
  }


  Container navbar() {
    return _showMenu == false ? null:Container(
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1, right: MediaQuery.of(context).size.width * 0.1, bottom: 25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          //boxShadow: [BoxShadow(color: Colors.black87, spreadRadius: 0, blurRadius: 10),],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: BottomNavigationBar(
          iconSize: 28,
          selectedItemColor: Colors.black,
          selectedIconTheme: IconThemeData(color: Colors.black, size: 28),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedIconTheme: IconThemeData(color: Colors.grey[400]),
          elevation: 50,
          backgroundColor: Colors.grey.withOpacity(0.5),
          currentIndex: _cIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(left: 20, top: 3),
                child: Icon(
                  Icons.explore,
                  color: dotColor,
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
              icon: Icon(
                  Icons.camera,
                  color: dotColor2
              ),
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
                child: Icon(
                  Icons.bookmark,
                  color: dotColor3
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(top: 3.0, right: 20),
                child: Icon(
                  FontAwesomeIcons.solidCircle,
                  size: 6.0,
                  color: dotColor3,
                ),
              ),
            ),BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(right: 20),
                child:  userProfilePic.isEmpty
                    ? Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.person, size: 28),
                )
                    : Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    // border: Border.all(
                    //   color: Colors.grey[700],
                    //   width: 0.1
                    // ),
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image:
                          CachedNetworkImageProvider(userProfilePic),
                          fit: BoxFit.cover)),
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(top: 0.0, right: 20),
                child: new Text(
                  userName??'',
                  style: new TextStyle(color: dotColor4, fontSize: 12),
                  textAlign: TextAlign.center,
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
                dotColor4 = Colors.white;
              });
            }

            if (index == 1) {
              setState(() {
                page = BlogPage();
                dotColor = Colors.white;
                dotColor1 = Colors.white;
                dotColor2 = Colors.black;
                dotColor3 = Colors.white;
                dotColor4 = Colors.white;
              });
            }

            if (index == 2) {
              setState(() async {
                //page = BookmarkPage();
                //page = MainCamera();
                //page = NewPostCameraPage();
                _showMenu = false;
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                      settings: RouteSettings(name:"Home"),
                      builder: (context) => NewPostCameraPage(
                        post: Post(),
                        tab: null,
                      )));


                _showMenu = true;

                dotColor = Colors.white;
                dotColor1 = Colors.white;
                dotColor2 = Colors.white;
                dotColor3 = Colors.black;
                dotColor4 = Colors.white;
              });
            }

            if (index == 3){
              setState(() {
                page = AccountPage();
                dotColor = Colors.white;
                dotColor1 = Colors.white;
                dotColor2 = Colors.white;
                dotColor3 = Colors.white;
                dotColor4 = Colors.black;

              });
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return whenBackButtonClicked();
      },
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar:Container(
            color: Colors.transparent,
            child: navbar()
          /*_showMenu
            ?navbar()
            :Container(
              color: Colors.transparent,
              width: 0,
              height: 0,
            )*/
        ),
        backgroundColor: Colors.transparent,
        body: page),
    );
  }

  @override
  void didUpdateWidget(NavBar oldWidget){
    super.didUpdateWidget(oldWidget);
    _getUserDetailsfromSP();
    _menuScroll();
  }

  @override
  void initState(){
    print("init");
    super.initState();
    _menuScroll();
  }

  @override
  void dispose(){
    _scrollController.removeListener((){});
    super.dispose();
  }

  void showBottomBar(){
    setState(() {
      _showMenu = true;
    });
  }

  void hideBottomBar(){
    setState(() {
      _showMenu = false;
    });
  }

  void _menuScroll() async {
    print("innnnn");
    _scrollController.addListener(()=>print(_scrollController.offset));
    _scrollController.addListener((){
      print("Listening");
      if(_scrollController.position.userScrollDirection == ScrollDirection.reverse){
        if(!isScrollingDown){
          print("not scroll");
          isScrollingDown = true;
          _showMenu = false;
          hideBottomBar();
        }
      }

      if(_scrollController.position.userScrollDirection == ScrollDirection.forward){
        if(isScrollingDown){
          print("scrolling");
          isScrollingDown = false;
          _showMenu = true;
          showBottomBar();
        }
      }
    });
  }

  // getting user data from shared preferances
  Future _getUserDetailsfromSP() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var name = sharedPreferences.getString('name') ?? 'name';
    var pic = sharedPreferences.getString('userProfilePic') ?? 'pic';
    setState(() {
      this.userName = name;
      this.userProfilePic = pic;
    });
    print(userName);
  }
}
