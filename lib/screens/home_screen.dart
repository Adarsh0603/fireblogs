import 'package:fireblogs/data/auth.dart';
import 'package:fireblogs/screens/add_blog_screen.dart';
import 'package:fireblogs/screens/user_blogs_screen.dart';
import 'package:fireblogs/widgets/home_screen_widgets/blogs_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi ${Provider.of<Auth>(context, listen: false).username}'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.of(context).pushNamed(UserBlogsScreen.routeName);
            },
          ),
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () async {
              await Provider.of<Auth>(context, listen: false).logOut();
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
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
