import 'package:flutter/material.dart';

class NoBlogsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: Text(
        'You didn\'t publish anything yet.',
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
    ));
  }
}
