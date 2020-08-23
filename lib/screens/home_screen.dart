import 'package:fireblogs/screens/add_blog_screen.dart';
import 'package:fireblogs/widgets/home_screen_widgets/blogs_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlogsList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.of(context).pushNamed(AddBlogScreen.routeName);
        },
        child: Icon(
          Icons.create,
          color: Colors.black,
        ),
      ),
    );
  }
}
