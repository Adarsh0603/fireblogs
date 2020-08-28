import 'package:fireblogs/data/blogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BlogCard extends StatelessWidget {
  final String blogId;

  BlogCard(this.blogId);

  @override
  Widget build(BuildContext context) {
    final blog = Provider.of<Blogs>(context).findBlogById(blogId);
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
      child: Material(
        elevation: 20,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Stack(children: [
                Positioned(
                  child: Container(
                    height: double.infinity,
                    child: Image.network(
                      blog.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    margin: EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            blog.blogTitle,
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            blog.blogContent.substring(0, 50),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                blog.blogTopic.toUpperCase(),
                              ),
                              Text(
                                DateFormat('MMMM dd, yyyy')
                                    .format(DateTime.parse(blog.blogDate)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ])),
        ),
      ),
    );
  }
}
