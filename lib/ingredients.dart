import 'package:flutter/material.dart';

class IngredientsPage extends StatelessWidget {
  const IngredientsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ingredients Screen"),
      ),
      body: Text("Search Recipe by Ingredients"),
    );
  }
}