import 'package:fireblogs/data/blogs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Blogs>(
        builder: (BuildContext context, blogs, _) => ListView.builder(
              itemBuilder: (ctx, i) => Text(blogs.blogs[i].blogTitle),
              itemCount: blogs.blogs.length,
            ));
  }
}
