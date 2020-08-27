import 'package:fireblogs/data/blogs.dart';
import 'package:fireblogs/models/blog.dart';
import 'package:fireblogs/widgets/add_blog_screen_widgets/feature_image_widget.dart';
import 'package:fireblogs/widgets/add_blog_screen_widgets/feature_placeholder_widget.dart';
import 'package:flutter/material.dart';
import 'package:fireblogs/constants.dart';
import 'package:provider/provider.dart';

class AddBlogScreen extends StatefulWidget {
  static const routeName = '/add-blog';
  @override
  _AddBlogScreenState createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String blogTitle;
  String blogContent;

  String imageUrl = '';
  bool fitImage = false;
  void onBlogSave(bool forUpdate, Blog userBlog) async {
    _formKey.currentState.save();
    FocusScope.of(context).unfocus();
    setState(() {
      isLoading = true;
    });
    if (forUpdate)
      await Provider.of<Blogs>(context, listen: false).updateBlog(
        blogTitle,
        blogContent,
        userBlog.id,
        imageUrl,
      );
    else
      await Provider.of<Blogs>(context, listen: false)
          .addBlog(blogTitle, blogContent, imageUrl);
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    bool forUpdate = false;
    final currentBlog = ModalRoute.of(context).settings.arguments as Blog;
    if (currentBlog != null) {
      forUpdate = true;
      imageUrl = currentBlog.imageUrl;
    }
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (imageUrl == '') FeatureImagePlaceHolder(),
              if (imageUrl != '')
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(children: [
                    FeatureImage(imageUrl, fitImage),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.filter_center_focus,
                          color: Colors.white60,
                        ),
                        onPressed: () {
                          setState(() {
                            fitImage = !fitImage;
                          });
                        },
                      ),
                    ),
                  ]),
                ),
              TextFormField(
                initialValue: currentBlog != null ? currentBlog.blogTitle : '',
                decoration: kTitleFieldInputDecoration,
                onSaved: (value) {
                  blogTitle = value;
                },
              ),
              Expanded(
                child: TextFormField(
                  initialValue:
                      currentBlog != null ? currentBlog.blogContent : '',
                  decoration: kContentFieldInputDecoration,
                  maxLines: 99,
                  onSaved: (value) {
                    blogContent = value;
                  },
                ),
              ),
              TextFormField(
                initialValue: currentBlog != null ? currentBlog.imageUrl : '',
                textInputAction: TextInputAction.go,
                decoration: kImageUrlFieldInputDecoration,
                onSaved: (value) {
                  imageUrl = value;
                },
                onFieldSubmitted: (value) {
                  setState(() {
                    imageUrl = value;
                  });
                },
              ),
              FlatButton(
                onPressed: () => onBlogSave(forUpdate, currentBlog),
                child: Text(isLoading ? 'Publishing...' : 'Publish Blog'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
