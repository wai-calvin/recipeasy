import 'package:flutter/material.dart';

class RandomPage extends StatelessWidget {
  const RandomPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Random Screen"),
      ),
      body: Text("Get Random Recipe"),
    );
  }
}