import 'package:fireblogs/data/blogs.dart';
import 'package:fireblogs/models/blog.dart';
import 'package:flutter/material.dart';
import 'package:fireblogs/constants.dart';
import 'package:provider/provider.dart';

class AddBlogScreen extends StatefulWidget {
  static const routeName = '/add-blog';
  @override
  _AddBlogScreenState createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String blogTitle;
  String blogContent;
  void onBlogSave(bool forUpdate, Blog userBlog) async {
    _formKey.currentState.save();
    setState(() {
      isLoading = true;
    });
    if (forUpdate)
      await Provider.of<Blogs>(context, listen: false)
          .updateBlog(blogTitle, blogContent, userBlog.id);
    else
      await Provider.of<Blogs>(context, listen: false)
          .addBlog(blogTitle, blogContent);
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    bool forUpdate = false;
    final currentBlog = ModalRoute.of(context).settings.arguments as Blog;
    if (currentBlog != null) forUpdate = true;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: currentBlog != null ? currentBlog.blogTitle : '',
                decoration: kTitleFieldInputDecoration,
                onSaved: (value) {
                  blogTitle = value;
                },
              ),
              TextFormField(
                initialValue:
                    currentBlog != null ? currentBlog.blogContent : '',
                decoration: kContentFieldInputDecoration,
                maxLines: 10,
                onSaved: (value) {
                  blogContent = value;
                },
              ),
              FlatButton(
                onPressed: () => onBlogSave(forUpdate, currentBlog),
                child: Text(isLoading ? 'Publishing...' : 'Publish Blog'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
