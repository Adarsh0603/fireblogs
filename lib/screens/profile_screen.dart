import 'package:fireblogs/constants.dart';
import 'package:fireblogs/data/auth.dart';
import 'package:fireblogs/data/blogs.dart';
import 'package:fireblogs/data/userProfile.dart';
import 'package:fireblogs/screens/profile.dart';
import 'package:fireblogs/widgets/add_blog_screen_widgets/normal_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<UserProfile>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        elevation: kAppBarElevation,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          'Your Profile',
          style: kAppBarTextStyle,
        ),
        actions: [
          FlatButton(
              child: Text(
                'LOGOUT',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 12),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Are you sure?'),
                    actions: [
                      FlatButton(
                        child: Text('Cancel'),
                        onPressed: () => Navigator.of(ctx).pop(),
                      ),
                      FlatButton(
                        child: Text('Logout'),
                        onPressed: () async {
//                          LOGOUT
                          Provider.of<Blogs>(context, listen: false)
                              .resetDataOnLogout();
                          Provider.of<UserProfile>(context, listen: false)
                              .resetFetchingBooleans();
                          await Provider.of<Auth>(context, listen: false)
                              .logOut();

                          Navigator.of(context).pushReplacementNamed('/');
                          Navigator.of(ctx).pop();
                        },
                      )
                    ],
                  ),
                );
              }),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: profile.reFetchUserProfile
                ? FutureBuilder(
                    future: profile.fetchSavedUserData(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      return snapshot.connectionState == ConnectionState.waiting
                          ? NormalLoader()
                          : Profile();
                    })
                : Profile(),
          ),
        ],
      ),
    );
  }
}
