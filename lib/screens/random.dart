import 'package:flutter/material.dart';
import 'package:recipeasy/services/api_services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RandomPage extends StatefulWidget {
  const RandomPage({Key key}) : super(key: key);
  @override
  RandomPageState createState() => RandomPageState();
}

class RandomPageState extends State<RandomPage> {
  //const RandomPage({Key key}) : super(key: key);

  void _getRandomRecipe(BuildContext context) async {
    List<String> tags = [];
    if(vegetarian){
      tags.add('vegetarian');
    }
    if(vegan){
      tags.add('vegan');
    }
    if(glutenFree){
      tags.add('glutenFree');
    }
    if(dairyFree){
      tags.add('dairyFree');
    }
    var recipe = await ApiService.instance.randomRecipe(tags.join(','));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RandomRecipe(recipe: recipe)),
    );
    //    print(recipe['spoonacularSourceUrl']);
  }

  bool vegetarian = false;
  bool glutenFree = false;
  bool vegan = false;
  bool dairyFree = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RECIPEASY"),
        centerTitle: true,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Vegetarian"),
                  Checkbox(
                    value: vegetarian,
                    onChanged: (bool value) {
                      setState(() {
                        vegetarian = value;
                      });
                    },
                  ),
                  Text("Vegan"),
                  Checkbox(
                    value: vegan,
                    onChanged: (bool value) {
                      setState(() {
                        vegan = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Gluten Free"),
                  Checkbox(
                    value: glutenFree,
                    onChanged: (bool value) {
                      setState(() {
                        glutenFree = value;
                      });
                    },
                  ),
                  Text("Dairy Free"),
                  Checkbox(
                    value: dairyFree,
                    onChanged: (bool value) {
                      setState(() {
                        dairyFree = value;
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
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
  final Map<String,dynamic> recipe;
  RandomRecipe({this.recipe});

  @override
  _RandomRecipeState createState() => _RandomRecipeState();
}

class _RandomRecipeState extends State<RandomRecipe> {

  void goToRecipe(String url){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ViewRecipe(url: url)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RECIPEASY"),
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                widget.recipe['title'],
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 237,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: NetworkImage(widget.recipe['image']),
                    fit: BoxFit.scaleDown,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12, offset: Offset(0, 2), blurRadius: 6)
                  ]),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.blueGrey[100],
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12, offset: Offset(0, 2), blurRadius: 6)
                ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Ready in: ${widget.recipe['readyInMinutes']} minutes',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child:  Text(
                      'Servings: ${widget.recipe['servings']}',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Vegan: ${widget.recipe['vegan']}",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Gluten Free: ${widget.recipe['glutenFree']}",
                    ),
                  ),
                ],
              )
              )],
            ),
        ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          goToRecipe(widget.recipe['spoonacularSourceUrl']);
        },
        label: Text('  See Recipe  '),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class ViewRecipe extends StatefulWidget {
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
