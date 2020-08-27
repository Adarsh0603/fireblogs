import 'package:flutter/material.dart';

class FeatureImage extends StatelessWidget {
  final String imageUrl;
  final bool fitImage;
  FeatureImage(this.imageUrl, this.fitImage);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        width: double.infinity,
        color: Colors.black,
        child: Image.network(
          imageUrl,
          fit: fitImage ? BoxFit.contain : BoxFit.cover,
        ),
      ),
    );
  }
}
