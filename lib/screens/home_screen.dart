import 'package:fireblogs/data/auth.dart';
import 'package:fireblogs/data/blogs.dart';
import 'package:fireblogs/widgets/custom_loader.dart';
import 'package:fireblogs/widgets/home_screen_widgets/blogs_list.dart';
import 'package:fireblogs/widgets/home_screen_widgets/random_blog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        title: Row(
          children: [
//            Container(
//                height: 48, width: 48, child: Image.asset('images/5.gif')),
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
              await Provider.of<Auth>(context, listen: false).logOut();
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            child: FutureBuilder(
              future:
                  Provider.of<Blogs>(context, listen: false).checkBlogsState(),
              builder:
                  (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
                      snapshot.connectionState == ConnectionState.done
                          ? RandomBlog()
                          : CustomLoader(size: 64),
            ),
          ),
          Expanded(child: BlogsList()),
        ],
      ),
    );
  }
}
