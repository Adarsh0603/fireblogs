import 'package:fireblogs/data/userProfile.dart';
import 'package:fireblogs/screens/profile.dart';
import 'package:fireblogs/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<UserProfile>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: profile.reFetchUserProfile
          ? FutureBuilder(
              future: profile.fetchSavedUserData(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return snapshot.connectionState == ConnectionState.waiting
                    ? CustomLoader()
                    : Profile();
              })
          : Profile(),
    );
  }
}
