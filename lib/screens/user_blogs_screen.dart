import 'package:fireblogs/constants.dart';
import 'package:fireblogs/data/blogs.dart';
import 'package:fireblogs/screens/add_blog_screen.dart';
import 'package:fireblogs/widgets/custom_loader.dart';
import 'package:fireblogs/widgets/no_blogs_widget.dart';
import 'package:fireblogs/widgets/user_blog_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserBlogsScreen extends StatelessWidget {
  static const routeName = '/user-blogs';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.create,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(AddBlogScreen.routeName);
            },
          )
        ],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Your Blogs',
          style: kAppBarTextStyle,
        ),
        backgroundColor: Colors.white,
      ),
      body: UserBlogsList(),
    );
  }
}

class UserBlogsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider.of<Blogs>(context, listen: false).reFetchUserBlogs == true
        ? FutureBuilder(
            future: Provider.of<Blogs>(context, listen: false)
                .fetchBlogsFromFirebase(true),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Provider.of<Blogs>(context, listen: false)
                    .setReFetchUserBlogs();
                return UserBlogsListWidget();
              } else
                return CustomLoader();
            },
          )
        : UserBlogsListWidget();
  }
}

class UserBlogsListWidget extends StatelessWidget {
  const UserBlogsListWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Blogs>(
      child: NoBlogsWidget(),
      builder: (BuildContext context, blogs, ch) => blogs.userBlogs.length == 0
          ? ch
          : ListView.builder(
              itemCount: blogs.userBlogs.length,
              itemBuilder: (ctx, i) => UserBlogItem(blogs.userBlogs[i], true),
            ),
    );
  }
}
