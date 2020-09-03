import 'package:connectivity/connectivity.dart';
import 'package:fireblogs/constants.dart';
import 'package:fireblogs/data/blogs.dart';
import 'package:fireblogs/data/userProfile.dart';
import 'package:fireblogs/screens/home_screen.dart';
import 'package:fireblogs/screens/profile_screen.dart';
import 'package:fireblogs/screens/splash_screen.dart';
import 'package:fireblogs/screens/user_blogs_screen.dart';
import 'package:fireblogs/widgets/network_builder.dart';
import 'package:fireblogs/widgets/no_network_flag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    ProfileScreen(),
  ];
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Connectivity().onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) if (mounted)
        setState(() {
          Provider.of<Blogs>(context, listen: false).restartApp();
          Provider.of<UserProfile>(context, listen: false).restartApp();
        });
    });
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NetworkBuilder(
          offlineChild: Column(
            children: [
              Expanded(child: SplashScreen()),
              NoNetworkFlag(),
            ],
          ),
          child: _children[_currentIndex]),
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
            title: Text(
              'YOUR BLOGS',
              style: kNavItemTextColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(
              'HOME',
              style: kNavItemTextColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text(
              'PROFILE',
              style: kNavItemTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
