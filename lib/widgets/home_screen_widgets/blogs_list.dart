import 'package:fireblogs/data/blogs.dart';
import 'package:fireblogs/widgets/custom_loader.dart';
import 'package:fireblogs/widgets/home_screen_widgets/blog_card.dart';
import 'package:fireblogs/widgets/home_screen_widgets/paginator.dart';
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
                .fetchBlogsFromFirebase(),
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Paginator(),
        Expanded(
          child: Consumer<Blogs>(
              child: Center(
                  child: Container(
                color: Colors.white,
                child: Image.asset(
                  'images/fail.gif',
                ),
              )),
              builder: (BuildContext context, blogs, child) =>
                  blogs.blogs.length == 0
                      ? child
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, i) => BlogCard(blogs.blogs[i].id),
                          itemCount: blogs.blogs.length,
                        )),
        ),
      ],
    );
  }
}
