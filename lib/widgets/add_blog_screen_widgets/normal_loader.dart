import 'package:flutter/material.dart';

class NormalLoader extends StatelessWidget {
  final double size;
  final Color color;

  NormalLoader({this.size = 18, this.color: Colors.black});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          )),
    );
  }
}
