import 'package:fireblogs/constants.dart';
import 'package:fireblogs/data/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String username;
  bool isLogin = true;
  void submit() async {
    _formKey.currentState.save();
    if (isLogin)
      await Provider.of<Auth>(context, listen: false)
          .signIn(email.trim(), password.trim());
    else
      await Provider.of<Auth>(context, listen: false)
          .signUp(email.trim(), password.trim(), username.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                if (!isLogin)
                  TextFormField(
                    decoration: kUsernameFieldInputDecoration,
                    onSaved: (value) {
                      username = value;
                    },
                  ),
                TextFormField(
                  decoration: kEmailFieldInputDecoration,
                  onSaved: (value) {
                    email = value;
                  },
                ),
                TextFormField(
                  decoration: kPasswordFieldInputDecoration,
                  onSaved: (value) {
                    password = value;
                  },
                ),
                FlatButton(
                  child: Text('signIn'),
                  onPressed: submit,
                ),
                FlatButton(
                  child: Text(!isLogin ? 'Sign In' : 'Create an Account'),
                  onPressed: () {
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
