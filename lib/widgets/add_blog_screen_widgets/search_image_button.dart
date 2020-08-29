import 'package:fireblogs/models/blog.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchImageButton extends StatelessWidget {
  const SearchImageButton({
    Key key,
    @required this.searchTerm,
  }) : super(key: key);

  final String searchTerm;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (ctx) => IconButton(
          icon: Icon(
            Icons.insert_link,
            color: Colors.grey,
          ),
          onPressed: () async {
            if (searchTerm == '')
              Scaffold.of(ctx).showSnackBar(SnackBar(
                content: Text('Fill in blog topic to search related images'),
                duration: Duration(seconds: 2),
              ));
            else {
              FocusScope.of(context).unfocus();
              var url = 'https://unsplash.com/s/photos/$searchTerm';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            }
          }),
    );
  }
}
