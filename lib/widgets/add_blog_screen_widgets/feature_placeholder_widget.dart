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
            'Image with Aspect Ratio 16:9 \nis recommended.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
