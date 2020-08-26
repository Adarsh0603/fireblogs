import 'dart:convert';

import 'package:fireblogs/models/blog.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Blogs with ChangeNotifier {
  String authToken;
  String userId;
  String _username;

  List<Blog> _blogs = [];
  List<Blog> _userBlogs = [];

  List<Blog> get blogs {
    return _blogs;
  }

  List<Blog> get userBlogs {
    return _userBlogs;
  }

  void update(String token, String user, String username) {
    authToken = token;
    userId = user;
    _username = username;

    notifyListeners();
  }

  Future<void> addBlog(String blogTitle, String blogContent) async {
    final url =
        "https://fireblogs-da7f6.firebaseio.com/blogs.json?auth=$authToken";

    final response = await http.post(url,
        body: jsonEncode({
          'blogTitle': blogTitle,
          'blogContent': blogContent,
          'authorId': userId,
          'authorName': _username,
        }));
    final responseData = jsonDecode(response.body);
    _blogs.add(Blog(
      responseData['name'],
      blogTitle,
      blogContent,
      _username,
    ));
    notifyListeners();
  }

  Future<void> fetchBlogsFromFirebase([bool filter = false]) async {
    String urlSegment = filter ? 'orderBy="authorId"&equalTo="$userId"' : '';

    final url =
        "https://fireblogs-da7f6.firebaseio.com/blogs.json?auth=$authToken&$urlSegment";
    final response = await http.get(url);
    final blogsData = jsonDecode(response.body) as Map<String, dynamic>;
    List<Blog> fetchedBlogs = [];
    blogsData.forEach((id, blog) {
      fetchedBlogs.add(
          Blog(id, blog['blogTitle'], blog['blogContent'], blog['authorName']));
    });
    if (filter)
      _userBlogs = fetchedBlogs;
    else
      _blogs = fetchedBlogs;

    notifyListeners();
  }

  Blog findBlogById(String id) {
    return _blogs.firstWhere((element) => element.id == id);
  }
}
