import 'package:fireblogs/data/blogs.dart';
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
  void onBlogSave() async {
    _formKey.currentState.save();
    setState(() {
      isLoading = true;
    });
    await Provider.of<Blogs>(context, listen: false)
        .addBlog(blogTitle, blogContent);
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: kTitleFieldInputDecoration,
                onSaved: (value) {
                  blogTitle = value;
                },
              ),
              TextFormField(
                decoration: kContentFieldInputDecoration,
                maxLines: 10,
                onSaved: (value) {
                  blogContent = value;
                },
              ),
              FlatButton(
                onPressed: onBlogSave,
                child: Text(isLoading ? 'Publishing...' : 'Publish Blog'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
