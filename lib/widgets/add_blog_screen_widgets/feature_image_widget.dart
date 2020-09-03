import 'package:fireblogs/widgets/add_blog_screen_widgets/normal_loader.dart';
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
        child: Image.network(imageUrl, loadingBuilder: (ctx, widget, progress) {
          if (progress == null) return widget;
          return Center(child: NormalLoader(bgColor: Colors.grey[200]));
        }, fit: !fitImage ? BoxFit.cover : BoxFit.contain),
      ),
    );
  }
}
