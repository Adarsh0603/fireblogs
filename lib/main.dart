import 'package:fireblogs/data/auth.dart';
import 'package:fireblogs/data/blogs.dart';
import 'package:fireblogs/screens/add_blog_screen.dart';
import 'package:fireblogs/screens/auth_screen.dart';
import 'package:fireblogs/screens/home_screen.dart';
import 'package:fireblogs/screens/user_blogs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Blogs>(
          create: (BuildContext context) => Blogs(),
          update: (_, auth, blogs) =>
              blogs..update(auth.token, auth.userId, auth.username),
        ),
      ],
      child: Consumer<Auth>(
        builder: (BuildContext context, auth, _) => MaterialApp(
          title: 'FireBlogs',
          home: auth.isAuth
              ? HomeScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? Center(child: CircularProgressIndicator())
                        : AuthScreen();
                  },
                ),
          routes: {
            AddBlogScreen.routeName: (ctx) => AddBlogScreen(),
            UserBlogsScreen.routeName: (ctx) => UserBlogsScreen(),
          },
        ),
      ),
    );
  }
}
