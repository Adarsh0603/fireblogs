import 'dart:convert';

import 'package:fireblogs/data/auth.dart';
import 'package:fireblogs/models/blog.dart';
import 'package:fireblogs/widgets/blog_screen_widgets/blog_actions_row.dart';
import 'package:fireblogs/widgets/custom_loader.dart';
import 'package:fireblogs/widgets/user_blog_item.dart';
import 'package:fireblogs/widgets/user_details_screen_widgets/publisher_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class UserDetailsScreen extends StatefulWidget {
  final String userId;
  UserDetailsScreen(this.userId);

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  String username;
  String userDetails;
  List<Blog> userBlogsList = [];
  Future<void> getUserData() async {
    final authToken = Provider.of<Auth>(context, listen: false).token;
    var url =
        "https://fireblogs-da7f6.firebaseio.com/users/${widget.userId}.json?auth=$authToken";
    var response = await http.get(url);
    var userDataResponse = jsonDecode(response.body);
    username = userDataResponse['username'];
    userDetails = userDataResponse['userDetails'];

    url =
        'https://fireblogs-da7f6.firebaseio.com/blogs.json?auth=$authToken&orderBy="authorId"&equalTo="${widget.userId}"';
    response = await http.get(url);
    final blogsData = jsonDecode(response.body) as Map<String, dynamic>;
    List<Blog> fetchedBlogs = [];
    blogsData.forEach((id, blog) {
      fetchedBlogs.add(Blog(
          id,
          blog['authorId'],
          blog['blogTitle'],
          blog['blogContent'],
          blog['authorName'],
          blog['blogTopic'],
          blog['blogDate'],
          blog['imageUrl'],
          blog['fitImage']));
    });
    userBlogsList = fetchedBlogs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder(
          future: getUserData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? CustomLoader()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlogActionsRow(),
                      PublisherDetails(username, userDetails),
                      SizedBox(height: 10),
                      Expanded(
                          child: ListView.builder(
                              itemCount: userBlogsList.length,
                              itemBuilder: (ctx, i) =>
                                  UserBlogItem(userBlogsList[i], false)))
                    ],
                  );
          },
        ),
      ),
    );
  }
}
