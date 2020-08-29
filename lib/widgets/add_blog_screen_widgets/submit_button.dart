import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final Function() onPressed;
  final bool isLoading;
  final String btnText;
  SubmitButton({this.onPressed, this.isLoading, this.btnText});

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
                    btnText,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
      ),
    );
  }
}
