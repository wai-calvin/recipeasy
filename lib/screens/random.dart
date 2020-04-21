import 'package:flutter/material.dart';
import 'package:recipeasy/services/api_services.dart';

class RandomPage extends StatelessWidget {
  const RandomPage({Key key}) : super(key: key);

  void _getRandomRecipe(BuildContext context) async {
    var recipe = await ApiService.instance.randomRecipe();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RandomRecipe(recipe: recipe)),
    );
    //    print(recipe['spoonacularSourceUrl']);
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
        onPressed: (){
           _getRandomRecipe(context);
        },
        label: Text('Get Random Recipe'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class RandomRecipe extends StatefulWidget {
  //It returns a final mealPlan variable
  final Map<String,dynamic> recipe;
  RandomRecipe({this.recipe});

  @override
  _RandomRecipeState createState() => _RandomRecipeState();
}

class _RandomRecipeState extends State<RandomRecipe> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RECIPEASY"),
        centerTitle: true,
      ),
      body: Text(widget.recipe['spoonacularSourceUrl']),
    );
  }
}
