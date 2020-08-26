import 'package:fireblogs/data/blogs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogCard extends StatelessWidget {
  final String blogId;

  BlogCard(this.blogId);

  @override
  Widget build(BuildContext context) {
    final blog = Provider.of<Blogs>(context).findBlogById(blogId);
    return Card(
      child: Column(
        children: [
          Text(blog.blogTitle),
          Text(blog.blogContent),
          Text(blog.authorName)
        ],
      ),
    );
  }
}
