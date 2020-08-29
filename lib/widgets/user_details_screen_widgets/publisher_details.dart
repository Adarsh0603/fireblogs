import 'package:fireblogs/constants.dart';
import 'package:flutter/material.dart';

class PublisherDetails extends StatelessWidget {
  final String username;
  final String userDetails;

  PublisherDetails(this.username, this.userDetails);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      padding: EdgeInsets.all(16),
      color: Colors.grey[100],
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            username,
            style: kPublisherUsernameTextStyle,
          ),
          SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
                child: Text(
              userDetails,
              style: kPublisherDetailsTextStyle,
            )),
          ),
        ],
      ),
    );
  }
}
