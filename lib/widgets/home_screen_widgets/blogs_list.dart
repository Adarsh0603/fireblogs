import 'package:fireblogs/data/blogs.dart';
import 'package:fireblogs/widgets/custom_loader.dart';
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
    return Provider.of<Blogs>(context, listen: false).reFetch == true
        ? FutureBuilder(
            future: Provider.of<Blogs>(context, listen: false)
                .fetchBlogsFromFirebase(false),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return BlogListWidget();
              } else
                return CustomLoader();
            },
          )
        : BlogListWidget();
  }
}

class BlogListWidget extends StatelessWidget {
  const BlogListWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Blogs>(
        builder: (BuildContext context, blogs, _) => ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, i) => BlogCard(blogs.blogs[i].id),
              itemCount: blogs.blogs.length,
            ));
  }
}
