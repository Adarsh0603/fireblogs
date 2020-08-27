import 'package:fireblogs/models/blog.dart';
import 'package:fireblogs/screens/add_blog_screen.dart';
import 'package:fireblogs/widgets/add_blog_screen_widgets/feature_image_widget.dart';
import 'package:flutter/material.dart';

class UserBlogItem extends StatelessWidget {
  final Blog userBlog;

  UserBlogItem(this.userBlog);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(AddBlogScreen.routeName, arguments: userBlog);
        },
        child: Card(
          elevation: 18,
          child: Stack(
            children: [
              Hero(
                  tag: userBlog.id,
                  child: FeatureImage(
                    userBlog.imageUrl,
                    userBlog.fitImage,
                  )),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black54,
                  padding: EdgeInsets.all(8),
                  child: Text(
                    userBlog.blogTitle,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
