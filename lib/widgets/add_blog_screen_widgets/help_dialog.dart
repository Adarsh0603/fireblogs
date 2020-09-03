import 'package:flutter/material.dart';

class HelpDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('How to add image link?'),
      content: RichText(
        text: TextSpan(
            style: TextStyle(fontSize: 16, color: Colors.grey),
            children: [
              TextSpan(
                  text:
                      'The image link should contain the actual image address.\nTo get the correct image link, long press any image and '),
              TextSpan(
                  text: '\n\'Open image in new tab\'',
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.grey[600])),
              TextSpan(
                  text:
                      '\nThen copy the url from the browser\'s search bar.\n\nYou can also use any gif\'s link to add a GIF as the blog image.\nClick '),
              WidgetSpan(
                child: Icon(
                  Icons.done,
                  size: 18,
                  color: Colors.blue,
                ),
              ),
              TextSpan(text: ' to see the preview.'),
            ]),
      ),
      actions: [
        FlatButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
