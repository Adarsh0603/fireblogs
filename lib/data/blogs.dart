import 'dart:async';
import 'dart:convert';

import 'package:fireblogs/date_enum.dart';
import 'package:fireblogs/models/blog.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Blogs with ChangeNotifier {
  String authToken;
  String userId;
  bool reFetch = true;
  bool reFetchUserBlogs = true;
  String _previousUsername; //to check whether username is changed or not
  String _username;
  List<Blog> _blogs = [];
  List<Blog> _userBlogs = [];
  var selectedDate = DateTime.now();
  Map<String, dynamic> weeklyData;

  List<Blog> get blogs {
    return _blogs.reversed.toList();
  }

  List<Blog> get userBlogs {
    return _userBlogs.reversed.toList();
  }

  void resetFetchingBooleans(
      [bool value = true, bool calledByPaginator = false]) {
    reFetch = value;
    if (calledByPaginator) return;
    reFetchUserBlogs = true;
  }

  void resetDataOnLogout() {
    reFetch = true;
    reFetchUserBlogs = true;
    selectedDate = DateTime.now();
  }

  void setReFetchUserBlogs() {
    reFetchUserBlogs = false;
  }

  Map<String, dynamic> get getWeekData {
    return weeklyData;
  }

  void update(String token, String user, String username) {
    _previousUsername = _username;
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
    final String blogDateFMT = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final response = await http.post(url,
        body: jsonEncode({
          'blogTitle': blogTitle,
          'blogContent': blogContent,
          'authorId': userId,
          'authorName': _username,
          'blogTopic': blogTopic,
          'blogDate': blogDate,
          'blogDateFMT': blogDateFMT,
          'imageUrl': imageUrl,
          'fitImage': fitImage
        }));
    final responseData = jsonDecode(response.body);
    final blog = Blog(responseData['name'], userId, blogTitle, blogContent,
        _username, blogTopic, blogDate, blogDateFMT, imageUrl, fitImage);
    _blogs.add(blog);
    _userBlogs.add(blog);
    notifyListeners();
    reFetch = true;
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

  Future<void> updateBlog(
      String blogTitle,
      String blogContent,
      String blogTopic,
      String blogId,
      String imageUrl,
      bool fitImage,
      String blogDate,
      String blogDateFMT) async {
    final url =
        "https://fireblogs-da7f6.firebaseio.com/blogs/$blogId.json?auth=$authToken";
    await http.put(url,
        body: jsonEncode({
          'blogTitle': blogTitle,
          'blogContent': blogContent,
          'authorId': userId,
          'authorName': _username,
          'blogTopic': blogTopic,
          'blogDate': blogDate,
          'blogDateFMT': blogDateFMT,
          'imageUrl': imageUrl,
          'fitImage': fitImage
        }));

    final index = _blogs.indexWhere((element) => element.id == blogId);
    final userBlogsIndex =
        _userBlogs.indexWhere((element) => element.id == blogId);
    final blog = Blog(blogId, userId, blogTitle, blogContent, _username,
        blogTopic, blogDate, blogDateFMT, imageUrl, fitImage);
    _blogs[index] = blog;
    _userBlogs[userBlogsIndex] = blog;

    notifyListeners();
    reFetch = true;
  }

  Map<String, String> selectWeek(DateType dateType) {
    DateTime startDate;
    DateTime endDate;
    if (dateType == DateType.today) {
      endDate = selectedDate;
      selectedDate = selectedDate.subtract(Duration(days: 7));
      startDate = selectedDate;
    }
    if (dateType == DateType.older) {
      endDate = selectedDate;
      selectedDate = selectedDate.subtract(Duration(days: 7));
      startDate = selectedDate;
    }
    if (dateType == DateType.newer) {
      selectedDate = selectedDate.add(Duration(days: 7));
      startDate = selectedDate;
      endDate = selectedDate.add(Duration(days: 7));
    }
    weeklyData = {'startDate': startDate, 'endDate': endDate};
    return {
      'startDate': DateFormat('yyyy-MM-dd').format(startDate),
      'endDate': DateFormat('yyyy-MM-dd').format(endDate),
    };
  }

  Future<void> fetchBlogsFromFirebase(
      [bool filter = false, DateType dateType = DateType.today]) async {
    if (reFetchUserBlogs == false && reFetch == false) return;
    reFetch = false;
    Map<String, String> weekMap;
    if (filter == false) weekMap = selectWeek(dateType);

    String urlSegment = filter
        ? 'orderBy="authorId"&equalTo="$userId"'
        : 'orderBy="blogDateFMT"&startAt="${weekMap['startDate']}"&endAt="${weekMap['endDate']}"';
    final url =
        'https://fireblogs-da7f6.firebaseio.com/blogs.json?auth=$authToken&$urlSegment';
    final response = await http.get(url);
    print('[fetchBlogsFromFirebase]-API CALL');
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
          blog['blogDateFMT'],
          blog['imageUrl'],
          blog['fitImage']));
    });
    if (filter)
      _userBlogs = fetchedBlogs;
    else
      _blogs = fetchedBlogs;
    notifyListeners();
  }

  void patchBlogsByUser() async {
    var url =
        "https://fireblogs-da7f6.firebaseio.com/users/$userId.json?auth=$authToken";
    var response = await http.get(url);
    var savedDataResponse = jsonDecode(response.body);
    var fetchedUsername = savedDataResponse['username'];
    if (_previousUsername == fetchedUsername) return;
    String urlSegment = 'orderBy="authorId"&equalTo="$userId"';
    url =
        'https://fireblogs-da7f6.firebaseio.com/blogs.json?auth=$authToken&$urlSegment';
    response = await http.get(url);
    var allUserBlogs = jsonDecode(response.body) as Map<String, dynamic>;
    allUserBlogs.forEach((key, value) async {
      final url =
          "https://fireblogs-da7f6.firebaseio.com/blogs/$key.json?auth=$authToken";
      await http.patch(url,
          body: jsonEncode({
            'authorName': _username,
          }));
    });
  }

  Blog findBlogById(String id) {
    return _blogs.firstWhere((element) => element.id == id);
  }

  Future<bool> checkBlogsState() async {
    await Future.delayed(Duration(seconds: 1)).then((_) async {
      if (_blogs.length == 0)
        await checkBlogsState();
      else
        return true;
    });
    return false;
  }
}
