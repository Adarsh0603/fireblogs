import 'dart:math';

import 'package:fireblogs/constants.dart';
import 'package:fireblogs/data/blogs.dart';
import 'package:fireblogs/models/blog.dart';
import 'package:fireblogs/screens/blog_screen.dart';
import 'package:fireblogs/widgets/home_screen_widgets/random_blog_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RandomBlog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.3;
    final blogs = Provider.of<Blogs>(context, listen: true).blogs;
    int randomIndex;
    Blog blog;
    if (blogs.length != 0) {
      randomIndex = Random().nextInt(blogs.length);
      blog = blogs[randomIndex];
    } else
      blog = null;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => BlogScreen(blog)));
      },
      child: Container(
        margin: EdgeInsets.all(16),
        width: double.infinity,
        height: width,
        child: blog == null
            ? Center(child: Text('No blogs found in this week'))
            : Row(
                children: [
                  RandomBlogImage(
                      width: width,
                      blogImage: blog.imageUrl,
                      elevation: 10.0,
                      rounded: true),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Expanded(
                          child: Text(
                            blog.blogContent,
                            style: kRandomBlogContentTextStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: (width * 0.03).toInt(),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                blog.blogTopic.toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                                style: kBlogTopicTextStyle,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              DateFormat('MMM dd, yyyy')
                                  .format(DateTime.parse(blog.blogDate)),
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
