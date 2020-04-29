import 'package:flutter/material.dart';
import 'package:recipeasy/services/api_services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({Key key}) : super(key: key);

  @override
  _RecipePageState createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void _getRecipe(BuildContext context, String input) async {
    var recipe = await ApiService.instance.findRecipe(input);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RecipePage()),
    );
    //    print(recipe['spoonacularSourceUrl']);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Recipes'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: myController,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _getRecipe(context, myController.text);
          },
          label: Text('Search Recipes'),
      ),
    );
  }
}