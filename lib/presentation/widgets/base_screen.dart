import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class BaseScreen extends StatelessWidget {
  final Widget body;
  AppBar? appBar;
  BaseScreen({
    Key? key,
    this.appBar,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      appBar: appBar,
    );
  }
}
