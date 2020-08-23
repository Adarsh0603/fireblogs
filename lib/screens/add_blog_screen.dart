import 'package:flutter/material.dart';
import 'package:fireblogs/constants.dart';

class AddBlogScreen extends StatefulWidget {
  static const routeName = '/add-blog';
  @override
  _AddBlogScreenState createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  final _formKey = GlobalKey<FormState>();

  String blogTitle;
  String blogContent;
  void onBlogSave() {
    _formKey.currentState.save();
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
