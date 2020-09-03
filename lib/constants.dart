import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kFireTitleTextStyle =
    TextStyle(color: Colors.orange, fontSize: 28, fontWeight: FontWeight.bold);
const kAppBarElevation = 1.0;
const kAppBarColor = Colors.white;
const kAppBarTextStyle =
    TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold);

const kNavItemTextColor = TextStyle(fontWeight: FontWeight.w500);
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
    labelText: 'Blog Image Link',
    labelStyle: TextStyle(color: Colors.grey),
    hintStyle: TextStyle(color: Colors.black26),
    hintText:
        'https://images.unsplash.com/photo-1489844097929-c8d5b91c456e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
    contentPadding: EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
    border: InputBorder.none);
const kAuthInputFieldDecoration =
    InputDecoration(labelText: '', labelStyle: TextStyle(color: Colors.grey));

const kAuthButtonTextStyle = TextStyle(
  fontSize: 18,
  color: Colors.grey,
);
const kAuthButtonSelectedTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

const kGreetingTextStyle = TextStyle(color: Colors.orange, fontSize: 32);
const kGreetingNameStyle =
    TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 32);
const kGreetingContentStyle =
    TextStyle(color: Colors.black38, fontWeight: FontWeight.w500, fontSize: 18);

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

const kUsernameFieldInputDecoration = InputDecoration(
    hintText: 'Name',
    border: InputBorder.none,
    hintStyle: TextStyle(color: Colors.black12));

const kUserDetailsFieldInputDecoration = InputDecoration(
  hintText: 'Add some more details',
  hintStyle: TextStyle(color: Colors.black12),
  border: InputBorder.none,
);

//User Details Screen Constants

const kPublisherUsernameTextStyle =
    TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black);
const kPublisherDetailsTextStyle =
    TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey);
const kBlogsLabelTextStyle =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 14);

const kPaginatorTextStyle =
    TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey);

final kRandomBlogBoxDecoration = BoxDecoration(
  color: Colors.grey[100],
);
