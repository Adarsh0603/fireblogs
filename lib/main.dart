import 'package:fireblogs/data/auth.dart';
import 'package:fireblogs/data/blogs.dart';
import 'package:fireblogs/screens/add_blog_screen.dart';
import 'package:fireblogs/screens/auth_screen.dart';
import 'package:fireblogs/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => Blogs(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (BuildContext context, auth, _) => MaterialApp(
          title: 'FireBlogs',
          home: auth.isAuth ? HomeScreen() : AuthScreen(),
          routes: {
            AddBlogScreen.routeName: (ctx) => AddBlogScreen(),
          },
        ),
      ),
    );
  }
}
