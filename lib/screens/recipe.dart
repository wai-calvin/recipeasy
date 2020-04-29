import 'package:flutter/material.dart';
import 'package:recipeasy/services/api_services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SearchRecipePage extends StatelessWidget {
  const SearchRecipePage({Key key}) : super(key: key);

  void _getRandomRecipe(BuildContext context) async {
    var recipe = await ApiService.instance.randomRecipe();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchRecipe(recipe: recipe)),
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

class SearchRecipe extends StatefulWidget {
  //It returns a final mealPlan variable
  final Map<String,dynamic> recipe;
  SearchRecipe({this.recipe});

  @override
  _SearchRecipeState createState() => _SearchRecipeState();
}

class _SearchRecipeState extends State<SearchRecipe> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RECIPEASY"),
        centerTitle: true,
      ),
      body: WebView(
        initialUrl: widget.recipe['spoonacularSourceUrl'],
        //JS unrestricted, so that JS can execute in the webview
        javascriptMode: JavascriptMode.unrestricted,
      ),
//      Text(widget.recipe['spoonacularSourceUrl']),
    );
  }
}
