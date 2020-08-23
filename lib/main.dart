import 'package:fireblogs/data/blogs.dart';
import 'package:fireblogs/screens/add_blog_screen.dart';
import 'package:fireblogs/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => Blogs(),
      child: MaterialApp(
        title: 'FireBlogs',
        home: HomeScreen(),
        routes: {
          AddBlogScreen.routeName: (ctx) => AddBlogScreen(),
        },
      ),
    );
  }
}
