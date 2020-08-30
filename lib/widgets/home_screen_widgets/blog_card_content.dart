import 'package:fireblogs/constants.dart';
import 'package:fireblogs/models/blog.dart';
import 'package:fireblogs/screens/blog_screen.dart';
import 'package:fireblogs/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BlogCardContent extends StatelessWidget {
  final Blog blog;
  BlogCardContent(this.blog);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BlogScreen(blog)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [Colors.black, Colors.transparent]),
            borderRadius: BorderRadius.all(kRoundedRadius)),
//        margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Utils.trimString(blog.blogTitle, 150),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      blog.blogTopic.toUpperCase(),
                      style: kBlogTopicTextStyle,
                    ),
                  ),
                  Text(
                    DateFormat('MMM dd').format(DateTime.parse(blog.blogDate)),
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
    );
  }
}
