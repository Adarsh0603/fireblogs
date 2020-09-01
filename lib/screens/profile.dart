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
  String btnText = 'Update Profile';
  bool isUpdated = false;

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  void onProfileSave() async {
    if (!_formKey.currentState.validate()) return;
    FocusScope.of(context).unfocus();

    _formKey.currentState.save();
    setState(() {
      isLoading = true;
    });
    await Provider.of<UserProfile>(context, listen: false)
        .updateProfile(username, userDetails);
    setState(() {
      isLoading = false;
      btnText = 'Updated Successfully';
      isUpdated = false;
    });
    Provider.of<Auth>(context, listen: false).updateUsername(username);
    Provider.of<Blogs>(context, listen: false).patchBlogsByUser();
  }

  void enableUpdate() {
    setState(() {
      isUpdated = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<UserProfile>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) return 'Username is required';
                          if (value.length < 4)
                            return 'Username must have atleast 4 characters.';
                          return null;
                        },
                        initialValue: profile.username,
                        decoration: kUsernameFieldInputDecoration,
                        onTap: enableUpdate,
                        style: TextStyle(
                            fontFamily: 'Noto',
                            fontWeight: FontWeight.w500,
                            fontSize: 24),
                        onSaved: (value) {
                          username = value;
                        },
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 8),
                        padding: EdgeInsets.only(
                            top: 0, bottom: 8, left: 16, right: 16),
                        decoration: BoxDecoration(
//                            border: Border.all(
//                                width: 0, color: Colors.lightBlueAccent[100]),
                            borderRadius: BorderRadius.all(kRoundedRadius)),
                        child: TextFormField(
                          initialValue: profile.userDetails,
                          onTap: enableUpdate,
                          maxLines: 99,
                          decoration: kUserDetailsFieldInputDecoration,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                          onSaved: (value) {
                            userDetails = value;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: isUpdated ? onProfileSave : null,
              child: Container(
                color: isUpdated ? Colors.lightBlueAccent : Colors.grey[400],
                width: double.infinity,
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      !isLoading ? btnText : 'Updating...',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
