import 'package:flutter/material.dart';

class FeatureImagePlaceHolder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        color: Colors.grey[200],
        child: Center(
          child: Text(
            'Image with Aspect Ratio 16:9 is recommended.',
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
