
import 'package:flutter/material.dart';
import 'package:morpheus/widgets/morpheus_tab_view.dart';

class MyTabScreen extends StatefulWidget {

  @override
  _MyTabScreenState createState() => _MyTabScreenState();

}

class _MyTabScreenState extends State<MyTabScreen> {

  final List<Widget> _screens = [
    Scaffold(backgroundColor: Colors.green),
    Scaffold(backgroundColor: Colors.red),
    Scaffold(backgroundColor: Colors.blue),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MorpheusTabView(
        child: _screens[_currentIndex]
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            title: Text('Trending'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Saved'),
          ),
        ],
        onTap: (index) {
          if (index != _currentIndex) {
            setState(() => _currentIndex = index);
          }
        },
      ),
    );
  }

}