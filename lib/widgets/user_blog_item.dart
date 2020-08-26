import 'package:fireblogs/models/blog.dart';
import 'package:fireblogs/screens/add_blog_screen.dart';
import 'package:flutter/material.dart';

class UserBlogItem extends StatelessWidget {
  final Blog userBlog;

  UserBlogItem(this.userBlog);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(AddBlogScreen.routeName, arguments: userBlog);
        },
        child: Card(
          child: Column(
            children: [
              Text(userBlog.blogTitle),
              Text(userBlog.blogContent),
            ],
          ),
        ),
      ),
    );
  }
}
