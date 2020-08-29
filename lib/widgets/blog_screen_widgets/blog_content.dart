import 'package:fireblogs/constants.dart';
import 'package:flutter/material.dart';

class BlogContent extends StatelessWidget {
  final String blogContent;

  BlogContent(this.blogContent);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16.0, top: 20, right: 16, bottom: 16),
          child: RichText(
            text: TextSpan(style: kBlogScreenContentTextStyle, children: [
              TextSpan(
                  text: blogContent[0],
                  style: kBlogScreenContentTextStyle.copyWith(
                      fontSize: 24, fontWeight: FontWeight.bold)),
              TextSpan(text: blogContent.substring(1)),
            ]),
          ),
        ),
      ),
    );
  }
}
