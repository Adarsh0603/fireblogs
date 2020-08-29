import 'package:fireblogs/constants.dart';
import 'package:fireblogs/models/blog.dart';
import 'package:fireblogs/screens/add_blog_screen.dart';
import 'package:fireblogs/screens/blog_screen.dart';
import 'package:fireblogs/utils.dart';
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
      padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
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
        child: Card(
          elevation: 2,
//          shadowColor: Colors.white,
          child: Container(
            margin: EdgeInsets.all(16),
            width: double.infinity,
            color: Colors.white,
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
                        Text(
                          Utils.trimString(userBlog.blogTitle, 40),
                          style: kRandomBlogTitleTextStyle,
                        ),
                        Spacer(),
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
      ),
    );
  }
}
