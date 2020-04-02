import 'package:flutter/material.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe Screen"),
      ),
      body: Text("Search Recipe"),
    );
  }
}