import 'package:fireblogs/data/auth.dart';
import 'package:fireblogs/data/userProfile.dart';
import 'package:fireblogs/widgets/add_blog_screen_widgets/submit_button.dart';
import 'package:fireblogs/widgets/custom_loader.dart';
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

  bool isLoading = false;

  void onProfileSave() async {
    _formKey.currentState.save();
    setState(() {
      isLoading = true;
    });
    await Provider.of<UserProfile>(context, listen: false)
        .updateProfile(username, userDetails);
    Provider.of<Auth>(context, listen: false).updateUsername(username);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<UserProfile>(context, listen: false);
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
        child: FutureBuilder(
          future: profile.savedData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? CustomLoader()
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: profile.username,
                          decoration: kUsernameFieldInputDecoration,
                          onSaved: (value) {
                            username = value;
                          },
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            initialValue: profile.userDetails,
                            maxLines: 99,
                            decoration: kUserDetailsFieldInputDecoration,
                            onSaved: (value) {
                              userDetails = value;
                            },
                          ),
                        ),
                      ),
                      SubmitButton(
                        isLoading: isLoading,
                        onPressed: onProfileSave,
                        btnText: 'SAVE',
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
