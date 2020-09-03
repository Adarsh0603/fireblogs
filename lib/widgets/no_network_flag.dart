import 'package:flutter/material.dart';

class NoNetworkFlag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      color: Colors.red,
      padding: EdgeInsets.all(16),
      child: Text(
        'No Internet Connection',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }
}
