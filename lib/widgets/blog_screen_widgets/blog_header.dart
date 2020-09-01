import 'package:fireblogs/constants.dart';
import 'package:fireblogs/models/blog.dart';
import 'package:fireblogs/screens/user_details_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BlogHeader extends StatelessWidget {
  final Blog blog;

  BlogHeader(this.blog);

  @override
  Widget build(BuildContext context) {
    final blogDate = DateTime.parse(blog.blogDate);
    return Container(
      padding: EdgeInsets.only(left: 16, bottom: 16, right: 16, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            blog.blogTopic.toUpperCase(),
            style: kBlogTopicTextStyle,
          ),
          SizedBox(height: 10),
          Text(
            blog.blogTitle,
            style: kBlogScreenTitleTextStyle,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  style: kBlogScreenMetaDataTextStyle,
                  children: [
                    TextSpan(text: 'Published by '),
                    TextSpan(
                        text: '${blog.authorName}',
                        style: kBlogScreenMetaDataTextStyle.copyWith(
                            fontWeight: FontWeight.w500),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        UserDetailsScreen(blog.authorId)));
                          })
                  ],
                ),
              ),
              Text(
                '${DateFormat.jm().format(blogDate)} - ${DateFormat('dd MMM, yyyy').format(blogDate)}',
                style: kBlogScreenMetaDataTextStyle,
              )
            ],
          )
        ],
      ),
    );
  }
}
