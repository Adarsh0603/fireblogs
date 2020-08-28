import 'package:fireblogs/models/blog.dart';
import 'package:fireblogs/widgets/add_blog_screen_widgets/feature_image_widget.dart';
import 'package:fireblogs/widgets/blog_screen_widgets/blog_actions_row.dart';
import 'package:fireblogs/widgets/blog_screen_widgets/blog_content.dart';
import 'package:fireblogs/widgets/blog_screen_widgets/blog_header.dart';
import 'package:flutter/material.dart';

class BlogScreen extends StatelessWidget {
  final Blog blog;

  BlogScreen(this.blog);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlogActionsRow(),
            BlogHeader(blog),
            FeatureImage(blog.imageUrl, blog.fitImage),
            BlogContent(blog.blogContent),
          ],
        ),
      ),
    );
  }
}
