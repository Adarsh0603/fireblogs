import 'package:fireblogs/constants.dart';
import 'package:flutter/material.dart';

class PublisherDetails extends StatelessWidget {
  final String username;
  final String userDetails;

  PublisherDetails(this.username, {this.userDetails = ''});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                username.toUpperCase(),
                style: kPublisherUsernameTextStyle,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: userDetails == ''
                  ? Center(
                      child: Text('No details available'),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          userDetails,
                          textAlign: TextAlign.start,
                          style: kPublisherDetailsTextStyle,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
