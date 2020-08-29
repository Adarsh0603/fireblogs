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
          fit: fitImage ? BoxFit.contain : BoxFit.cover,
          placeholder: kTransparentImage,
          imageErrorBuilder:
              (BuildContext context, Object exception, StackTrace stackTrace) {
            return Center(child: Text('Cant get the image'));
          },
        ),
      ),
    );
  }
}
