import 'package:fireblogs/data/blogs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserBlogsScreen extends StatelessWidget {
  static const routeName = '/user-blogs';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Blogs'),
      ),
      body: UserBlogsList(),
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
              itemCount: blogs.blogs.length,
              itemBuilder: (ctx, i) => Text(blogs.blogs[i].blogTitle),
            ),
          );
        } else
          return CircularProgressIndicator();
      },
    );
  }
}
