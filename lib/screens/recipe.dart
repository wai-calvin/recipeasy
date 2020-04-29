import 'package:flutter/material.dart';
import 'package:recipeasy/services/api_services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipePage extends StatelessWidget {
  //const RecipePage({Key key}) : super(key: key);
  final myController = TextEditingController();

  void _getRecipe(BuildContext context, String input) async {
    var recipe = await ApiService.instance.findRecipe(input);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FindRecipe(recipe: recipe)),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: myController,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          _getRecipe(context, myController.text);
        },
        label: Text('Get Random Recipe'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class FindRecipe extends StatefulWidget {
  final Map<String, dynamic> recipe;
  FindRecipe({this.recipe});

  @override
  _FindRecipeState createState() => _FindRecipeState();
}

class _FindRecipeState extends State<FindRecipe> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}