import 'package:fireblogs/constants.dart';
import 'package:fireblogs/models/blog.dart';
import 'package:fireblogs/screens/add_blog_screen.dart';
import 'package:fireblogs/screens/blog_screen.dart';
import 'package:fireblogs/widgets/home_screen_widgets/random_blog_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserBlogItem extends StatelessWidget {
  final Blog userBlog;
  final bool sameUser;
  UserBlogItem(this.userBlog, this.sameUser);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.3;

    return Padding(
      padding: const EdgeInsets.only(top: 1.0, left: 0, right: 0),
      child: GestureDetector(
        onTap: () {
          if (sameUser)
            Navigator.of(context)
                .pushNamed(AddBlogScreen.routeName, arguments: userBlog);
          else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => BlogScreen(userBlog)));
          }
        },
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.grey[100])),
            color: Colors.white,
          ),
          width: double.infinity,
          child: Row(
            children: [
              RandomBlogImage(width: width, blogImage: userBlog.imageUrl),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            userBlog.blogTitle,
                            style: kRandomBlogTitleTextStyle,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Published On - ${DateFormat('dd MMM yyyy').format(DateTime.parse(userBlog.blogDate))}',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
