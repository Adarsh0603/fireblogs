import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kRoundedRadius = Radius.circular(8);
const kBlogFieldInputDecoration = InputDecoration(
    isCollapsed: true,
    hintText: 'Blog Title',
    hintStyle: TextStyle(fontSize: 14),
    border: InputBorder.none,
    focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black12, width: 2)),
    enabledBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
    contentPadding: EdgeInsets.only(top: 16, bottom: 8, left: 8, right: 8));

const kContentFieldInputDecoration = InputDecoration(
    hintText: 'Blog Content',
    border: InputBorder.none,
    hintStyle: TextStyle(fontSize: 14),
    contentPadding: EdgeInsets.only(top: 16, bottom: 8, left: 8, right: 8));

const kImageUrlFieldInputDecoration = InputDecoration(
//  isCollapsed: true,
    hintText: 'Feature Image Link',
    contentPadding: EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
    border: InputBorder.none);
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
  fontSize: 18,
  fontWeight: FontWeight.w500,
);
const kRandomBlogContentTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  height: 1.1,
);

//Blog Screen constants

const kBlogScreenTitleTextStyle =
    TextStyle(fontSize: 22, fontWeight: FontWeight.w500);
const kBlogScreenMetaDataTextStyle =
    TextStyle(fontSize: 12, color: Colors.grey);
const kBlogScreenContentTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 16,
);

//Profile Screen Constants

const kUsernameFieldInputDecoration =
    InputDecoration(hintText: 'Name', border: InputBorder.none);

const kUserDetailsFieldInputDecoration = InputDecoration(
  hintText: 'Add about you',
  border: InputBorder.none,
//  enabledBorder: OutlineInputBorder(
//    borderSide: BorderSide(color: Colors.black12),
//  ),
//  focusedBorder: OutlineInputBorder(
//    borderSide: BorderSide(width: 2, color: Colors.black12),
//  ),
);

//User Details Screen Constants

const kPublisherUsernameTextStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w600,
);
const kPublisherDetailsTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
);
