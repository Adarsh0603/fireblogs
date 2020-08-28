import 'package:flutter/material.dart';

class FitImage extends StatelessWidget {
  final bool fitImage;
  final Function() onPressed;

  FitImage({this.fitImage, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: IconButton(
        icon: Icon(
          !fitImage ? Icons.center_focus_strong : Icons.settings_overscan,
          color: !fitImage ? Colors.white60 : Colors.black,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
