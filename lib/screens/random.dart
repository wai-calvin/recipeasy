import 'package:flutter/material.dart';
import 'package:recipeasy/services/api_services.dart';

//class RecipeScreen extends StatefulWidget {
//  //This stateful widget page takes in String mealType and Recipe recipe
//  final String mealType;
//  final Recipe recipe;
//
//  RecipeScreen({this.mealType, this.recipe});
//
//
//  @override
//  _RecipeScreenState createState() => _RecipeScreenState();
//}

class RandomPage extends StatelessWidget {
  const RandomPage({Key key}) : super(key: key);

  void _getRandomRecipe() async {
    await ApiService.instance.randomRecipe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RECIPEASY"),
        centerTitle: true,
      ),
      body: Text("Get Random Recipe"),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _getRandomRecipe,
        label: Text('Get Random Recipe'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}