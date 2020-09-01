import 'package:fireblogs/constants.dart';
import 'package:flutter/material.dart';

class PublisherDetails extends StatelessWidget {
  final String username;
  final String userDetails;

  PublisherDetails(this.username, this.userDetails);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
      child: Material(
        color: Colors.white,
//        shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.all(kRoundedRadius)),
        elevation: 8,
        shadowColor: Colors.white,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.3,
          padding: EdgeInsets.all(32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                username.toUpperCase(),
                style: kPublisherUsernameTextStyle,
              ),
              SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    userDetails,
                    textAlign: TextAlign.start,
                    style: kPublisherDetailsTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
