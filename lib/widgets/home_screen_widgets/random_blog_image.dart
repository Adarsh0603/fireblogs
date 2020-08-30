import 'package:fireblogs/constants.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class RandomBlogImage extends StatelessWidget {
  final double width;
  final String blogImage;
  RandomBlogImage({this.width, this.blogImage});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(kRoundedRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(kRoundedRadius),
        child: Container(
          width: width,
          height: width,
          child: FadeInImage.memoryNetwork(
            image: blogImage,
            fit: BoxFit.cover,
            placeholder: kTransparentImage,
          ),
        ),
      ),
    );
  }
}
