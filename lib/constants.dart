import 'package:flutter/material.dart';

const kRoundedRadius = Radius.circular(8);
const kTitleFieldInputDecoration = InputDecoration(
  hintText: 'Blog Title',
);
const kTopicFieldInputDecoration = InputDecoration(
  hintText: 'Blog Topic',
);
const kContentFieldInputDecoration = InputDecoration(
  hintText: 'Blog Content',
  border: InputBorder.none,
);
const kImageUrlFieldInputDecoration = InputDecoration(
//  isCollapsed: true,
  hintText: 'Feature Image Link',
);
const kAuthInputFieldDecoration = InputDecoration(
  labelText: '',
);

const kAuthButtonTextStyle = TextStyle(
  fontSize: 18,
  color: Colors.grey,
);
const kAuthButtonSelectedTextStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

const kGreetingTextStyle = TextStyle(color: Colors.black, fontSize: 32);
const kGreetingNameStyle =
    TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 32);
const kGreetingContentStyle = TextStyle(color: Colors.grey, fontSize: 18);

const kAppBarTextStyle = TextStyle(color: Colors.black);

const kBlogTopicTextStyle =
    TextStyle(color: Colors.orange, fontSize: 12, fontWeight: FontWeight.bold);

const kRandomBlogTitleTextStyle = TextStyle(
  fontSize: 8,
  fontWeight: FontWeight.w500,
);
const kRandomBlogContentTextStyle = TextStyle(
  fontWeight: FontWeight.w500,
);

//Blog Screen constants

const kBlogScreenTitleTextStyle =
    TextStyle(fontSize: 22, fontWeight: FontWeight.w500);
const kBlogScreenMetaDataTextStyle =
    TextStyle(fontSize: 12, color: Colors.grey);
const kBlogScreenContentTextStyle = TextStyle(
  fontSize: 16,
);
