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
      MaterialPageRoute(builder: (context) => RecipeResults(recipe: recipe)),
    );
    //print(recipe['results'][0]['title']);
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
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://spoonacular.com/recipeImages/" +
                         widget.recipe['results'][index]['image']
                  ),
                  fit: BoxFit.scaleDown,
                ),
              ),
              child: Text(widget.recipe['results'][index]['title']),
            ),
          );
        },
      )
    );
  }

//    @override
//    Widget build(BuildContext context) {
//      return Scaffold(
//        appBar: AppBar(
//          title: Text("RECIPEASY"),
//          centerTitle: true,
//        ),
//        body: Container(
//          child: ListView(
//            padding: const EdgeInsets.all(8),
//            children: <Widget>[
//              Padding(
//                padding: EdgeInsets.all(16.0),
//                child: Text(
//                  widget.recipe['results'][0]['title'],
//                  textAlign: TextAlign.center,
//                  style: TextStyle(
//                      fontSize: 25,
//                      fontWeight: FontWeight.bold),
//                ),
//              ),
//              Container(
//                height: 237,
//                width: double.infinity,
//                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
//                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                decoration: BoxDecoration(
//                    color: Colors.white,
//                    image: DecorationImage(
//                      image: NetworkImage("https://spoonacular.com/recipeImages/" +
//                          widget.recipe['results'][0]['image']
//                      ),
//                      fit: BoxFit.scaleDown,
//                    ),
//                    borderRadius: BorderRadius.circular(15),
//                    boxShadow: [
//                      BoxShadow(
//                          color: Colors.black12, offset: Offset(0, 2), blurRadius: 6)
//                    ]),
//              ),
//              Container(
//                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                  decoration: BoxDecoration(
//                      color: Colors.blueGrey[100],
//                      borderRadius: BorderRadius.circular(15),
//                      boxShadow: [
//                        BoxShadow(
//                            color: Colors.black12, offset: Offset(0, 2), blurRadius: 6)
//                      ]),
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      Padding(
//                        padding: EdgeInsets.all(8.0),
//                        child: Text(
//                          'Ready in: ${widget.recipe['results'][0]['readyInMinutes']} minutes',
//                        ),
//                      ),
//                      Padding(
//                        padding: EdgeInsets.all(8.0),
//                        child:  Text(
//                          'Servings: ${widget.recipe['results'][0]['servings']}',
//                        ),
//                      ),
//                    ],
//                  )
//              )],
//          ),
//        ),
//        floatingActionButton: FloatingActionButton.extended(
//          onPressed: (){
//            goToRecipe(widget.recipe['spoonacularSourceUrl']);
//          },
//          label: Text('  See Recipe  '),
//        ),
//        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //);
    }



//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("RECIPEASY"),
//        centerTitle: true,
//      ),
//      body: new ListView.builder(
//        itemCount: 3,
//        itemBuilder: (BuildContext context, int index) {
//          return Dismissible(
//            child: Card(
//              elevation: 5,
//              child: Container(
//                height: 50.0,
//                child: Row(
//                  children: <Widget>[
//                    Text(widget.recipe['results'][index]['title']),
//                  ]
//                )
//              )
//            ),
//          );
//          //return new Text(widget.recipe['results'][index]['title']);
//        },
//      )
//
//    );
//  }
//}

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


