import 'package:fireblogs/widgets/custom_loader.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          CustomLoader(),
//          Positioned(
//            top: 420,
//            child: Text(
//              'fireblogs',
//              style: TextStyle(
//                  fontWeight: FontWeight.bold,
//                  fontSize: 36,
//                  color: Colors.orange),
//            ),
//          ),
        ],
      ),
    );
  }
}
