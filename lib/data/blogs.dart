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
    return _blogs.reversed.toList();
  }

  List<Blog> get userBlogs {
    return _userBlogs.reversed.toList();
  }

  void update(String token, String user, String username) {
    authToken = token;
    userId = user;
    _username = username;
    notifyListeners();
  }

  Future<void> addBlog(String blogTitle, String blogContent, String blogTopic,
      String imageUrl, bool fitImage) async {
    final url =
        "https://fireblogs-da7f6.firebaseio.com/blogs.json?auth=$authToken";
    final String blogDate = DateTime.now().toIso8601String();
    final response = await http.post(url,
        body: jsonEncode({
          'blogTitle': blogTitle,
          'blogContent': blogContent,
          'authorId': userId,
          'authorName': _username,
          'blogTopic': blogTopic,
          'blogDate': blogDate,
          'imageUrl': imageUrl,
          'fitImage': fitImage
        }));
    final responseData = jsonDecode(response.body);
    final blog = Blog(responseData['name'], blogTitle, blogContent, _username,
        blogTopic, blogDate, imageUrl, fitImage);
    _blogs.add(blog);
    _userBlogs.add(blog);
    notifyListeners();
  }

  Future<void> deleteBlog(String blogId) async {
    final url =
        "https://fireblogs-da7f6.firebaseio.com/blogs/$blogId.json?auth=$authToken";
    await http.delete(url);
    final index = _blogs.indexWhere((element) => element.id == blogId);

    _userBlogs.removeWhere((element) => element.id == blogId);
    _blogs.removeAt(index);

    notifyListeners();
  }

  Future<void> updateBlog(String blogTitle, String blogContent,
      String blogTopic, String blogId, String imageUrl, bool fitImage) async {
    final url =
        "https://fireblogs-da7f6.firebaseio.com/blogs/$blogId.json?auth=$authToken";
    final String blogDate = DateTime.now().toIso8601String();
    final index = _blogs.indexWhere((element) => element.id == blogId);
    final userBlogsIndex =
        _userBlogs.indexWhere((element) => element.id == blogId);
    final blog = Blog(blogId, blogTitle, blogContent, _username, blogTopic,
        blogDate, imageUrl, fitImage);
    _blogs[index] = blog;
    _userBlogs[userBlogsIndex] = blog;

    notifyListeners();
    await http.put(url,
        body: jsonEncode({
          'blogTitle': blogTitle,
          'blogContent': blogContent,
          'authorId': userId,
          'authorName': _username,
          'blogTopic': blogTopic,
          'blogDate': blogDate,
          'imageUrl': imageUrl,
          'fitImage': fitImage
        }));
  }

  Future<void> fetchBlogsFromFirebase([bool filter = false]) async {
    String urlSegment = filter ? 'orderBy="authorId"&equalTo="$userId"' : '';

    final url =
        'https://fireblogs-da7f6.firebaseio.com/blogs.json?auth=$authToken&$urlSegment';
    final response = await http.get(url);
    final blogsData = jsonDecode(response.body) as Map<String, dynamic>;
    List<Blog> fetchedBlogs = [];
    blogsData.forEach((id, blog) {
      fetchedBlogs.add(Blog(
          id,
          blog['blogTitle'],
          blog['blogContent'],
          blog['authorName'],
          blog['blogTopic'],
          blog['blogDate'],
          blog['imageUrl'],
          blog['fitImage']));
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
