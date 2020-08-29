import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class FeatureImage extends StatelessWidget {
  final String imageUrl;
  final bool fitImage;
  final double aspectRatio;
  FeatureImage(this.imageUrl, this.fitImage, [this.aspectRatio = 16 / 9]);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Container(
        width: double.infinity,
        color: Colors.grey[200],
        child: FadeInImage.memoryNetwork(
          image: imageUrl,
//          placeholder: NetworkImage(
//              'https://ak.picdn.net/shutterstock/videos/1030928504/thumb/9.jpg?ip=x480'),
          fit: fitImage ? BoxFit.contain : BoxFit.cover,
          placeholder: kTransparentImage,
        ),
      ),
    );
  }
}
