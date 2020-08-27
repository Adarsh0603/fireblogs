import 'package:fireblogs/constants.dart';
import 'package:fireblogs/data/blogs.dart';
import 'package:fireblogs/screens/add_blog_screen.dart';
import 'package:fireblogs/widgets/user_blog_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserBlogsScreen extends StatelessWidget {
  static const routeName = '/user-blogs';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Your Blogs',
          style: kAppBarTextStyle,
        ),
        backgroundColor: Colors.white,
      ),
      body: UserBlogsList(),
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

class UserBlogsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Blogs>(context, listen: false)
          .fetchBlogsFromFirebase(true),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Consumer<Blogs>(
            builder: (BuildContext context, blogs, _) => ListView.builder(
              itemCount: blogs.userBlogs.length,
              itemBuilder: (ctx, i) => UserBlogItem(blogs.userBlogs[i]),
            ),
          );
        } else
          return Center(child: CircularProgressIndicator());
      },
    );
  }
}
