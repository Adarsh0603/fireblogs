import 'package:flutter/material.dart';

class PublishButton extends StatelessWidget {
  final Function() onPressed;
  final bool isLoading;

  PublishButton({this.onPressed, this.isLoading});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: Colors.grey[200],
        height: 50,
        child: Center(
            child: isLoading
                ? Container(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.grey[400]),
                    ),
                  )
                : Text(
                    'PUBLISH',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
      ),
    );
  }
}
