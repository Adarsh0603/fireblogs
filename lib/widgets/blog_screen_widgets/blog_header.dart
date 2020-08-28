import 'package:fireblogs/constants.dart';
import 'package:fireblogs/models/blog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BlogHeader extends StatelessWidget {
  final Blog blog;

  BlogHeader(this.blog);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
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
              Text(
                'Publihsed by ${blog.authorName}',
                style: kBlogScreenMetaDataTextStyle,
              ),
              Text(
                DateFormat('dd MMM, yyyy')
                    .format(DateTime.parse(blog.blogDate)),
                style: kBlogScreenMetaDataTextStyle,
              )
            ],
          )
        ],
      ),
    );
  }
}
