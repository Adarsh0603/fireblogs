import 'package:fireblogs/constants.dart';
import 'package:fireblogs/data/auth.dart';
import 'package:fireblogs/models/http_exception.dart';
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
  String greetingName = '';
  bool isLoading = false;
  final _passwordController = TextEditingController();
  bool isLogin = true;

  void submit(BuildContext context) async {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    FocusScope.of(context).unfocus();
    try {
      setState(() {
        isLoading = true;
      });
      if (isLogin)
        await Provider.of<Auth>(context, listen: false)
            .signIn(email.trim(), password.trim());
      else
        await Provider.of<Auth>(context, listen: false)
            .signUp(email.trim(), password.trim(), username.trim());
    } on HttpException catch (e) {
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        duration: Duration(seconds: 2),
      ));
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Builder(
        builder: (ctx) => CircleAvatar(
          radius: 28,
          backgroundColor: Colors.black,
          child: isLoading
              ? CircularProgressIndicator(
                  backgroundColor: Colors.black,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.white,
                  ),
                  onPressed: () => submit(ctx),
                ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FlatButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Text(
                          'Sign In',
                          style: isLogin
                              ? kAuthButtonSelectedTextStyle
                              : kAuthButtonTextStyle,
                        ),
                        onPressed: () {
                          setState(() {
                            isLogin = true;
                          });
                        },
                      ),
                      FlatButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Text(
                          'Sign Up',
                          style: !isLogin
                              ? kAuthButtonSelectedTextStyle
                              : kAuthButtonTextStyle,
                        ),
                        onPressed: () {
                          setState(() {
                            isLogin = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GreetingsWidget(greetingName.trim(), isLogin),
                      SizedBox(height: 50),
                      if (!isLogin)
                        TextFormField(
                          validator: (value) {
                            if (value.length < 4)
                              return 'Username should be atleast 4 characters long.';
                            if (value.isEmpty)
                              return 'Please enter a username.';
                            else
                              return null;
                          },
                          decoration: kAuthInputFieldDecoration.copyWith(
                              labelText: 'Username'),
                          onSaved: (value) {
                            username = value;
                          },
                          onChanged: (value) {
                            setState(() {
                              greetingName = value;
                            });
                          },
                        ),
                      SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@'))
                            return 'Please enter a valid email address';
                          else
                            return null;
                        },
                        decoration: kAuthInputFieldDecoration.copyWith(
                            labelText: 'Email address'),
                        onSaved: (value) {
                          email = value;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        obscureText: true,
                        controller: _passwordController,
                        validator: (value) {
                          if (value.isEmpty) return 'Please enter a password.';
                          if (value.length < 6)
                            return 'Password should be atleast 6 characters long.';
                          else
                            return null;
                        },
                        decoration: kAuthInputFieldDecoration.copyWith(
                            labelText: 'Password'),
                        onSaved: (value) {
                          password = value;
                        },
                      ),
                      SizedBox(height: 10),
                      if (!isLogin)
                        TextFormField(
                          obscureText: true,
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Please confirm password.';
                            if (value != _passwordController.text)
                              return 'Password did not match.';
                            else
                              return null;
                          },
                          decoration: kAuthInputFieldDecoration.copyWith(
                              labelText: 'Confirm Password'),
                          onSaved: (value) {
                            password = value;
                          },
                        ),
                      SizedBox(height: 80),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GreetingsWidget extends StatefulWidget {
  final String username;
  final bool isLogin;

  GreetingsWidget(this.username, this.isLogin);

  @override
  _GreetingsWidgetState createState() => _GreetingsWidgetState();
}

class _GreetingsWidgetState extends State<GreetingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!widget.isLogin)
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Hello',
                  style: kGreetingTextStyle,
                ),
                TextSpan(
                  text: ' ${widget.username}',
                  style: kGreetingNameStyle,
                ),
                if (widget.username.length > 0)
                  TextSpan(
                    text: ', ',
                    style: kGreetingNameStyle,
                  ),
              ],
            ),
          ),
        if (!widget.isLogin)
          Text(
            'Welcome to FireBlogs.\nCreate a New Account',
            style: kGreetingContentStyle,
          )
      ],
    );
  }
}
