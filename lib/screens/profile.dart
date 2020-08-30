import 'package:fireblogs/data/auth.dart';
import 'package:fireblogs/data/blogs.dart';
import 'package:fireblogs/data/userProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fireblogs/constants.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String username;
  String userDetails;

  final _formKey = GlobalKey<FormState>();

  void onProfileSave() async {
    _formKey.currentState.save();
    await Provider.of<UserProfile>(context, listen: false)
        .updateProfile(username, userDetails);
    Provider.of<Auth>(context, listen: false).updateUsername(username);
    Provider.of<Blogs>(context, listen: false).patchBlogsByUser();

    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Updated Successfully'),
      duration: Duration(seconds: 1),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<UserProfile>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          'Manage Your Profile',
          style: kAppBarTextStyle,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: onProfileSave,
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                initialValue: profile.username,
                decoration: kUsernameFieldInputDecoration,
                onSaved: (value) {
                  username = value;
                },
              ),
              Expanded(
                child: TextFormField(
                  initialValue: profile.userDetails,
                  maxLines: 99,
                  decoration: kUserDetailsFieldInputDecoration,
                  onSaved: (value) {
                    userDetails = value;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
