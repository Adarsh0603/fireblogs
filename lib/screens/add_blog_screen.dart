import 'package:fireblogs/data/blogs.dart';
import 'package:fireblogs/models/blog.dart';
import 'package:fireblogs/widgets/add_blog_screen_widgets/delete_loader.dart';
import 'package:fireblogs/widgets/add_blog_screen_widgets/feature_image_widget.dart';
import 'package:fireblogs/widgets/add_blog_screen_widgets/feature_placeholder_widget.dart';
import 'package:fireblogs/widgets/add_blog_screen_widgets/fit_image_widget.dart';
import 'package:fireblogs/widgets/add_blog_screen_widgets/search_image_button.dart';
import 'package:fireblogs/widgets/add_blog_screen_widgets/submit_button.dart';
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
  bool isDeleting = false;
  String blogTitle;
  String blogTopic = '';
  String blogContent;
  String imageUrl = '';
  String searchTerm = '';
  bool fitImage = false;
  bool forUpdate = false;
  bool isInit = true;

  void onBlogSave(bool forUpdate, Blog userBlog) async {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    FocusScope.of(context).unfocus();
    setState(() {
      isLoading = true;
    });
    if (forUpdate)
      await Provider.of<Blogs>(context, listen: false).updateBlog(
          blogTitle,
          blogContent,
          blogTopic,
          userBlog.id,
          imageUrl,
          fitImage,
          userBlog.blogDate);
    else
      await Provider.of<Blogs>(context, listen: false)
          .addBlog(blogTitle, blogContent, blogTopic, imageUrl, fitImage);

    Navigator.of(context).pop();
  }

  void delete(String blogId) async {
    setState(() {
      isDeleting = true;
    });
    await Provider.of<Blogs>(context, listen: false).deleteBlog(blogId);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final currentBlog = ModalRoute.of(context).settings.arguments as Blog;
    if (currentBlog != null && isInit) {
      forUpdate = true;
      imageUrl = currentBlog.imageUrl;
      searchTerm = currentBlog.blogTopic;
      fitImage = currentBlog.fitImage;
      isInit = false;
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          currentBlog != null ? 'Edit Blog' : 'Create Blog',
          style: kAppBarTextStyle,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (currentBlog != null)
            isDeleting
                ? DeleteLoader()
                : IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                    onPressed: () => delete(currentBlog.id),
                  )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height -
              AppBar().preferredSize.height -
              MediaQuery.of(context).padding.top,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (imageUrl == '') FeatureImagePlaceHolder(),
                if (imageUrl != '')
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Stack(children: [
                      Hero(
                          tag: currentBlog != null ? currentBlog.id : '',
                          child: FeatureImage(imageUrl, fitImage)),
                      FitImage(
                        fitImage: fitImage,
                        onPressed: () {
                          setState(() {
                            fitImage = !fitImage;
                          });
                        },
                      )
                    ]),
                  ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                style: TextStyle(fontSize: 14),
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'Image Url is required';
                                  return null;
                                },
                                initialValue: currentBlog != null
                                    ? currentBlog.imageUrl
                                    : '',
                                textInputAction: TextInputAction.done,
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
                            ),
                            SearchImageButton(searchTerm: searchTerm)
                          ],
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value.isEmpty) return 'Blog Title is required';
                            return null;
                          },
                          textCapitalization: TextCapitalization.sentences,
                          initialValue:
                              currentBlog != null ? currentBlog.blogTitle : '',
                          decoration: kBlogFieldInputDecoration,
                          onSaved: (value) {
                            blogTitle = value;
                          },
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value.isEmpty) return 'Blog Topic is required';
                            return null;
                          },
                          textCapitalization: TextCapitalization.sentences,
                          initialValue:
                              currentBlog != null ? currentBlog.blogTopic : '',
                          decoration: kBlogFieldInputDecoration.copyWith(
                              hintText: 'Blog Topic'),
                          onSaved: (value) {
                            blogTopic = value;
                          },
                          onChanged: (value) {
                            blogTopic = value;
                            setState(() {
                              searchTerm = value;
                            });
                          },
                        ),
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              if (value.length < 20)
                                return 'Content should be atleast 200 characters';
                              return null;
                            },
                            textCapitalization: TextCapitalization.sentences,
                            initialValue: currentBlog != null
                                ? currentBlog.blogContent
                                : '',
                            decoration: kContentFieldInputDecoration,
                            maxLines: 99,
                            onSaved: (value) {
                              blogContent = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SubmitButton(
                  onPressed: () => onBlogSave(forUpdate, currentBlog),
                  isLoading: isLoading,
                  btnText: 'PUBLISH',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
