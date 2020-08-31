import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  final double size;
  CustomLoader({this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: size, height: size, child: Image.asset('images/1.gif')),
    );
  }
}
