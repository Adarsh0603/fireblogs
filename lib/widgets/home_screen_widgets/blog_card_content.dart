import 'package:fireblogs/constants.dart';
import 'package:fireblogs/models/blog.dart';
import 'package:fireblogs/screens/blog_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BlogCardContent extends StatelessWidget {
  final Blog blog;
  BlogCardContent(this.blog);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 5,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BlogScreen(blog)),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          width: MediaQuery.of(context).size.width * 0.62,
          height: MediaQuery.of(context).size.height * 0.2,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.blogTitle,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
//                          Text(
//                            blog.blogContent.substring(0, 50),
//                          ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      blog.blogTopic.toUpperCase(),
                      style: kBlogTopicTextStyle,
                    ),
                    Text(
                      DateFormat('MMMM dd, yyyy')
                          .format(DateTime.parse(blog.blogDate)),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
