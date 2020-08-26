import 'package:fireblogs/data/blogs.dart';
import 'package:fireblogs/widgets/home_screen_widgets/blog_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogsList extends StatefulWidget {
  @override
  _BlogsListState createState() => _BlogsListState();
}

class _BlogsListState extends State<BlogsList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Blogs>(context, listen: false)
          .fetchBlogsFromFirebase(false),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Consumer<Blogs>(
              builder: (BuildContext context, blogs, _) => ListView.builder(
                    itemBuilder: (ctx, i) => BlogCard(blogs.blogs[i].id),
                    itemCount: blogs.blogs.length,
                  ));
        } else
          return Center(child: CircularProgressIndicator());
      },
    );
  }
}
