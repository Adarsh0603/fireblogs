import 'dart:math';

import 'package:fireblogs/constants.dart';
import 'package:fireblogs/data/blogs.dart';
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
    final blogs = Provider.of<Blogs>(context, listen: false).blogs;
    int randomIndex = Random().nextInt(blogs.length);
    final blog = blogs[randomIndex];
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
        color: Colors.white,
        child: Row(
          children: [
            RandomBlogImage(width: width, blogImage: blog.imageUrl),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
//                  Text(
//                    blog.blogTitle,
//                    style: kRandomBlogTitleTextStyle,
//                    overflow: TextOverflow.ellipsis,
//                  ),
                  Expanded(
                    child: Text(
                      blog.blogContent,
                      style: kRandomBlogContentTextStyle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
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
