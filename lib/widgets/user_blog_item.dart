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
  final double elevation;
  UserBlogItem(this.userBlog, this.sameUser, {this.elevation = 4});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.25;

    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
      child: GestureDetector(
        onTap: !sameUser
            ? null
            : () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            BlogScreen(userBlog)));
              },
        child: Material(
          elevation: elevation,
          child: Container(
            padding: EdgeInsets.only(
                top: 12, left: 12, right: 12, bottom: sameUser ? 4 : 12),
            decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(width: 1, color: Colors.grey[100])),
              color: Colors.white,
            ),
            width: double.infinity,
            child: Column(
              children: [
                Row(
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
                              child: Text(
                                userBlog.blogTitle,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: kRandomBlogTitleTextStyle,
                              ),
                            ),
                            SizedBox(height: 10),
                            !sameUser
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          userBlog.blogTopic.toUpperCase(),
                                          overflow: TextOverflow.ellipsis,
                                          style: kBlogTopicTextStyle,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        DateFormat('MMM dd').format(
                                            DateTime.parse(userBlog.blogDate)),
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${DateFormat('dd MMM yyyy').format(DateTime.parse(userBlog.blogDate))}',
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
                if (sameUser) SizedBox(height: 10),
                if (sameUser)
                  Divider(
                    height: 0,
//                    thickness: 2,
                  ),
                if (sameUser) SizedBox(height: 4),
                if (sameUser)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FlatButton(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        child: Text(
                          'Read',
                          style: TextStyle(color: Colors.blue),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      BlogScreen(userBlog)));
                        },
                      ),
                      FlatButton(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        child: Text(
                          'Edit',
                          style: TextStyle(color: Colors.blue),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              AddBlogScreen.routeName,
                              arguments: userBlog);
                        },
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
