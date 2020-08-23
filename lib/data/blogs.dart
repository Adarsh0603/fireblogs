import 'dart:convert';

import 'package:fireblogs/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Blogs with ChangeNotifier {
  List<Blog> _blogs = [];

  List<Blog> get blogs {
    return _blogs;
  }

  Future<void> addBlog(String blogTitle, String blogContent) async {
    const url = "https://fireblogs-da7f6.firebaseio.com/blogs.json";

    final response = await http.post(url,
        body: jsonEncode({
          'blogTitle': blogTitle,
          'blogContent': blogContent,
        }));
    final responseData = jsonDecode(response.body);
    _blogs.add(Blog(responseData['name'], blogTitle, blogContent));

    notifyListeners();
  }
}
