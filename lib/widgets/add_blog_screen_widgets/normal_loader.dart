import 'package:flutter/material.dart';

class NormalLoader extends StatelessWidget {
  final double size;

  NormalLoader({this.size = 18});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            )),
      ),
    );
  }
}
