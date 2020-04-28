import 'package:flutter/material.dart';
import 'package:recipeasy/services/api_services.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
              height: 275,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: NetworkImage(widget.recipe['image']),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12, offset: Offset(0, 2), blurRadius: 6)
                  ]),
            ),
          ],
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
