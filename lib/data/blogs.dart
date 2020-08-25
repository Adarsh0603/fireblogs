import 'dart:convert';

import 'package:fireblogs/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Blogs with ChangeNotifier {
  String authToken;
  String userId;

  List<Blog> _blogs = [];

  List<Blog> get blogs {
    return _blogs;
  }

  void update(String token, String user) {
    authToken = token;
    userId = user;

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
        }));
    final responseData = jsonDecode(response.body);
    _blogs.add(Blog(responseData['name'], blogTitle, blogContent));
    notifyListeners();
  }

  Future<void> fetchBlogsFromFirebase([bool userBlogs = false]) async {
    String urlSegment = userBlogs ? 'orderBy="authorId"&equalTo="$userId"' : '';

    final url =
        "https://fireblogs-da7f6.firebaseio.com/blogs.json?auth=$authToken&$urlSegment";
    print(url);
    final response = await http.get(url);
    final blogsData = jsonDecode(response.body) as Map<String, dynamic>;
    List<Blog> fetchedBlogs = [];
    blogsData.forEach((id, blog) {
      fetchedBlogs.add(Blog(id, blog['blogTitle'], blog['blogContent']));
    });
    _blogs = fetchedBlogs;
    notifyListeners();
  }

  Blog findBlogById(String id) {
    return _blogs.firstWhere((element) => element.id == id);
  }
}
