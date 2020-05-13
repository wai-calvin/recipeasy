import 'package:flutter/material.dart';
import 'package:recipeasy/services/api_services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recipeasy/screens/recentSearched.dart';

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

  Future<void> _showSearch() async {
    final searchText = await showSearch<String>(
      context: context,
      delegate: SearchWithSuggestionDelegate(
        onSearchChanged: _getRecentSearchesLike,
      ),
    );
    await _saveToRecentSearches(searchText);
  }

  Future<List<String>> _getRecentSearchesLike(String query) async {
    final pref = await SharedPreferences.getInstance();
    final allSearches = pref.getStringList("recentSearches");
    return allSearches.where((search) => search.startsWith(query)).toList();
  }

  Future<void> _saveToRecentSearches(String searchText) async {
    if (searchText == null) return;
    final pref = await SharedPreferences.getInstance();

    Set<String> allSearches =
        pref.getStringList("recentSearches")?.toSet() ?? {};

    allSearches = {searchText, ...allSearches};
    pref.setStringList("recentSearches", allSearches.toList());
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
        title: Text('Recipeasy'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 370,
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
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
            ]
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _getRecipe(context, myController.text);
          },
          label: Text('Search'),
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
    _save(int id) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> myList = (prefs.getStringList('mylist') ?? List<String>());

      if(myList.length > 2){
        myList.removeLast();
      }
      myList.insert(0, id.toString());
      await prefs.setStringList('mylist', myList);
    }

    void goToRecipe(int id) async{
      _save(id);
      var url = await ApiService.instance.retrieveUrl(id);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ViewRecipe(url: url)),
      );
    }

    @override
    Widget build(BuildContext context){
      return Scaffold(
          appBar: AppBar(
            title: Text("Recipeasy"),
            centerTitle: true,
          ),
          body: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                    color: Colors.blueGrey[100],
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: InkWell(
                      onTap: () {goToRecipe(widget.recipe['results'][index]['id']);},
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(5, 7, 5, 10),
                        child: Column(
                          children: <Widget>[
                            Text(
                              widget.recipe['results'][index]['title'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.network(
                                  "https://spoonacular.com/recipeImages/" +
                                      widget.recipe['results'][index]['image'],
                                fit: BoxFit.scaleDown,
                                height: 300,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                );
              }
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


