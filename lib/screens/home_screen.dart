import 'package:fireblogs/data/auth.dart';
import 'package:fireblogs/data/blogs.dart';
import 'package:fireblogs/data/userProfile.dart';
import 'package:fireblogs/widgets/home_screen_widgets/blogs_list.dart';
import 'package:fireblogs/widgets/home_screen_widgets/random_blog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Row(
          children: [
            Text(
              'Fireblogs',
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        actions: [
          FlatButton(
            child: Text('LOGOUT'),
            onPressed: () async {
              Provider.of<Blogs>(context, listen: false).resetDataOnLogout();
              Provider.of<UserProfile>(context, listen: false)
                  .resetFetchingBooleans();
              await Provider.of<Auth>(context, listen: false).logOut();
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => onRefresh(context),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: blogs.reFetch
                  ? FutureBuilder(
                      future: blogs.checkBlogsState(),
                      builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) =>
                          snapshot.connectionState == ConnectionState.done
                              ? RandomBlog()
                              : Container(),
                    )
                  : RandomBlog(),
            ),
            Expanded(child: BlogsList()),
          ],
        ),
      ),
    );
  }
}
