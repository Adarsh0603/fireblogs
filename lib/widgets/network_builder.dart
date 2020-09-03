import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class NetworkBuilder extends StatelessWidget {
  final Widget offlineChild;
  final Widget child;
  NetworkBuilder({this.offlineChild, this.child});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: Connectivity().onConnectivityChanged,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.data == ConnectivityResult.none) return offlineChild;
        return child;
      },
    );
  }
}
