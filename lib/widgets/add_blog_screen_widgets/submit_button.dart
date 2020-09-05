import 'package:fireblogs/widgets/network_builder.dart';
import 'package:fireblogs/widgets/no_network_flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final Function() onPressed;
  final bool isLoading;
  final String btnText;
  SubmitButton({this.onPressed, this.isLoading, this.btnText});

  @override
  Widget build(BuildContext context) {
    return NetworkBuilder(
      offlineChild: NoNetworkFlag(),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          color: Colors.grey[200],
          height: MediaQuery.of(context).size.height * 0.08,
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
      ),
    );
  }
}
