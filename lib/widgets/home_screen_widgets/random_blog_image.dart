import 'package:fireblogs/constants.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class RandomBlogImage extends StatelessWidget {
  final double width;
  final String blogImage;
  final double elevation;
  final bool rounded;
  RandomBlogImage(
      {this.width, this.blogImage, this.elevation = 0, this.rounded = false});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.all(rounded ? kRoundedRadius : Radius.circular(0)),
      ),
      child: ClipRRect(
        borderRadius:
            BorderRadius.all(rounded ? kRoundedRadius : Radius.circular(0)),
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
