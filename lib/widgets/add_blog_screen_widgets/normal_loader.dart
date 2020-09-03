import 'package:flutter/material.dart';

class NormalLoader extends StatelessWidget {
  final double size;
  final Color color;
  final Color bgColor;

  NormalLoader(
      {this.size = 18, this.color: Colors.black, this.bgColor: Colors.white});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            backgroundColor: bgColor,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          )),
    );
  }
}
