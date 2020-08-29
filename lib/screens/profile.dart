import 'package:fireblogs/widgets/add_blog_screen_widgets/submit_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fireblogs/constants.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Manage Your Profile',
          style: kAppBarTextStyle,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: kUsernameFieldInputDecoration,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 99,
                  decoration: kUserDetailsFieldInputDecoration,
                ),
              ),
            ),
            SubmitButton(
              isLoading: isLoading,
              onPressed: () {},
              btnText: 'SAVE',
            ),
          ],
        ),
      ),
    );
  }
}
