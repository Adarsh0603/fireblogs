import 'package:fireblogs/screens/home_screen.dart';
import 'package:fireblogs/screens/profile.dart';
import 'package:fireblogs/screens/user_blogs_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 1;
  final List<Widget> _children = [
    UserBlogsScreen(),
    HomeScreen(),
    Profile(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
//        showSelectedLabels: false,
//        showUnselectedLabels: false,
        selectedFontSize: 12,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.orange,
        backgroundColor: Colors.white,
//        elevation: 2,
        onTap: onTabTapped, // new

        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            title: Text('YOUR BLOGS'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('HOME'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
      ),
    );
  }
}
