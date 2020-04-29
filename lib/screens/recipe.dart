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
//    Navigator.push(
//      context,
//      MaterialPageRoute(builder: (context) => RecipeResults(recipe: recipe)),
//    );
    if(recipe['results'][0]['title'] == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NoRecipeResults()),
      );
    }

    else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RecipeResults(recipe: recipe)),
      );
    }
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
          decoration: InputDecoration(
            hintText: 'Enter Recipe...',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide(color: Colors.greenAccent, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide(color: Colors.greenAccent),
            ),
          ),
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

class RecipeResults extends StatefulWidget {
  final Map<String, dynamic> recipe;
  RecipeResults({this.recipe});

  @override
  _RecipeResultState createState() => _RecipeResultState();
}

class _RecipeResultState extends State<RecipeResults> {

    void goToRecipe(String url){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ViewRecipe(url: url)),
      );
    }

    @override
    Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Recipes"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                child: Column(
                  children: <Widget>[
                    Text(widget.recipe['results'][index]['title']),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(
                          "https://spoonacular.com/recipeImages/" +
                          widget.recipe['results'][index]['image']
                      ),
                    )
                  ],
                ),
              )
          );
        },
      )
    );
  }
}

class NoRecipeResults extends StatefulWidget {
  @override
  _NoRecipeResultState createState() => _NoRecipeResultState();
}

class _NoRecipeResultState extends State<NoRecipeResults> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Recipes'),
      ),
      body: Text('No results found.'),
    );
  }
}


class ViewRecipe extends StatefulWidget {
  //It returns a final mealPlan variable
  final String url;
  ViewRecipe({this.url});

  @override
  _ViewRecipeState createState() => _ViewRecipeState();
}

class _ViewRecipeState extends State<ViewRecipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RECIPEASY"),
        centerTitle: true,
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}


