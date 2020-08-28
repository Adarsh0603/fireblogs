import 'package:fireblogs/data/blogs.dart';
import 'package:fireblogs/widgets/add_blog_screen_widgets/feature_image_widget.dart';
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
      padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
      child: Material(
        elevation: 20,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
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
                Positioned(
                  bottom: 20,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.2,
                    color: Colors.white,
                    child: Text('Tere'),
                  ),
                ),
              ])),
        ),
      ),
    );
  }
}
