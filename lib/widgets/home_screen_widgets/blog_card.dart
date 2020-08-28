import 'package:fireblogs/data/blogs.dart';
import 'package:fireblogs/widgets/home_screen_widgets/blog_card_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogCard extends StatelessWidget {
  final String blogId;

  BlogCard(this.blogId);

  @override
  Widget build(BuildContext context) {
    final blog = Provider.of<Blogs>(context).findBlogById(blogId);
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 32.0, top: 16.0),
      child: Material(
        elevation: 14,
        shadowColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Stack(children: [
                Positioned(
                  child: Container(
                    height: double.infinity,
                    child: Image.network(
                      blog.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                BlogCardContent(blog),
              ])),
        ),
      ),
    );
  }
}
