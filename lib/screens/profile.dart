import 'package:fireblogs/data/auth.dart';
import 'package:fireblogs/data/blogs.dart';
import 'package:fireblogs/data/userProfile.dart';
import 'package:fireblogs/widgets/add_blog_screen_widgets/normal_loader.dart';
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

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  void onProfileSave() async {
    _formKey.currentState.save();
    setState(() {
      isLoading = true;
    });
    await Provider.of<UserProfile>(context, listen: false)
        .updateProfile(username, userDetails);
    setState(() {
      isLoading = false;
      btnText = 'Updated Successfully';
    });
    FocusScope.of(context).unfocus();
    Provider.of<Auth>(context, listen: false).updateUsername(username);
    Provider.of<Blogs>(context, listen: false).patchBlogsByUser();
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
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextFormField(
                        initialValue: profile.username,
                        decoration: kUsernameFieldInputDecoration,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 24),
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
                          maxLines: 99,
                          decoration: kUserDetailsFieldInputDecoration,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 18),
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
              onTap: onProfileSave,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(4),
                        bottomRight: Radius.circular(4))),
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
