import 'package:fireblogs/constants.dart';
import 'package:fireblogs/data/blogs.dart';
import 'package:fireblogs/widgets/add_blog_screen_widgets/normal_loader.dart';
import 'package:fireblogs/widgets/home_screen_widgets/blogs_list.dart';
import 'package:fireblogs/widgets/home_screen_widgets/random_blog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;

  Future<void> onRefresh(BuildContext context) async {
    final blogsProvider = Provider.of<Blogs>(context, listen: false);
    blogsProvider.resetFetchingBooleans();
    await blogsProvider.fetchBlogsFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    final blogs = Provider.of<Blogs>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: kAppBarElevation,
        iconTheme: IconThemeData(color: Colors.black),
        title: Hero(
          tag: 'title',
          child: Text(
            'fireblogs',
            style: kFireTitleTextStyle,
          ),
        ),
        actions: [
          isLoading
              ? Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: NormalLoader(
                    size: 14,
                    color: Colors.grey,
                  ),
                )
              : IconButton(
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.grey,
                  ),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await onRefresh(context);
                    setState(() {
                      isLoading = false;
                    });
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'Blogs are up-to-date.',
                        style: TextStyle(color: Colors.yellow),
                      ),
                      duration: Duration(seconds: 1),
                    ));
                  },
                )
        ],
        backgroundColor: kAppBarColor,
      ),
      body: Column(
        children: [
          Container(
            decoration: kRandomBlogBoxDecoration,

//            height: MediaQuery.of(context).size.width * 0.4,
            child: blogs.reFetch
                ? FutureBuilder(
                    future: blogs.checkBlogsState(),
                    builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) =>
                        snapshot.connectionState == ConnectionState.done
                            ? RandomBlog()
                            : Container(
                                height: MediaQuery.of(context).size.width * 0.3,
                                decoration: kRandomBlogBoxDecoration,
                                margin: EdgeInsets.all(16),
                                child: Center(),
                              ),
                  )
                : RandomBlog(),
          ),
          Expanded(child: BlogsList()),
        ],
      ),
    );
  }
}
