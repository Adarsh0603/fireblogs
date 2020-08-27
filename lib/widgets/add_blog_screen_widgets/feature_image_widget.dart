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
        color: Colors.grey[200],
        child: Image.network(
          imageUrl,
          fit: fitImage ? BoxFit.contain : BoxFit.cover,
        ),
      ),
    );
  }
}
