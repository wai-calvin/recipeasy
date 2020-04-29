import 'package:flutter/material.dart';
import 'package:recipeasy/services/api_services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class IngredientsPage extends StatefulWidget {
  const IngredientsPage({Key key}) : super(key: key);
  @override
  _IngredientPageState createState() => _IngredientPageState();
}

class _IngredientPageState extends State<IngredientsPage>{
  List<String> _ingredients = [];

  final myController = TextEditingController();
//  ScrollController _scrollController = new ScrollController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  Widget myInput(){
    return Container(
      width: 370,
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      child: TextField(
        autocorrect: true,
        controller: myController,
        onSubmitted: (myController) {
          _addToList(myController);
          this.myController.clear();
        },
        decoration: InputDecoration(
          hintText: 'Enter Ingredients...',
          hintStyle: TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white70,
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
    );
  }

  Widget _ingredientList() {
    return ListView.builder(
        itemCount: _ingredients.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(_ingredients[index]),
              onTap: () => _removeIngredientPrompt(index,1),
            ),
          );
        }
    );
  }

  void _addToList(String ingredient) {
    if(ingredient.length > 0) {
      // Putting our code inside "setState" tells the app that our state has changed, and
      // it will automatically re-render the list
      setState(() => _ingredients.add(ingredient));
    }
  }

  void _removeIngredientPrompt(int index, int mode) {
    if (mode == 1){
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
                title: new Text('Remove "${_ingredients[index]}"?'),
                actions: <Widget>[
                  new FlatButton(
                      child: new Text('CANCEL'),
                      onPressed: () => Navigator.of(context).pop()
                  ),
                  new FlatButton(
                      child: new Text('REMOVE'),
                      textColor: Colors.red,
                      onPressed: () {
                        _removeIngredient(index);
                        Navigator.of(context).pop();
                      }
                  )
                ]
            );
          }
      );
    }
    else if (mode == 2){
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
                title: new Text('Clear Ingredients List?'),
                actions: <Widget>[
                  new FlatButton(
                      child: new Text('CANCEL'),
                      onPressed: () => Navigator.of(context).pop()
                  ),
                  new FlatButton(
                      child: new Text('REMOVE'),
                      textColor: Colors.red,
                      onPressed: () {
                        _clearList();
                        Navigator.of(context).pop();
                      }
                  )
                ]
            );
          }
      );
    }
  }

  void _removeIngredient(int index) {
    setState(() => _ingredients.removeAt(index));
  }

  void _clearList(){
    setState(() => _ingredients.clear());
  }

  void _getRecipeByIngr(BuildContext context, List <String>ingr) async {
    var ingr = _ingredients.join(',');
    var recipes = await ApiService.instance.recipeByIngr(ingr);
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RecipesFound(recipes: recipes)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RECIPEASY"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            myInput(),
            Expanded(
              child: _ingredientList(),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: FloatingActionButton(
                  heroTag: 'btn1',
                  onPressed: (){
                    _removeIngredientPrompt(null, 2);
                  },
                  child: Icon(Icons.clear),
                ),
              ),
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton.extended(
                heroTag: 'btn2',
                onPressed: (){
                  _getRecipeByIngr(context,_ingredients);
                },
                label: Text('Get Recipe By Ingredients'),
              ),
            ]
          ),
        ],
      ),
    );
  }
}

class RecipesFound extends StatefulWidget {
  //It returns a final mealPlan variable
  final List<dynamic> recipes;
  RecipesFound({this.recipes});

  @override
  _RecipesFoundState createState() => _RecipesFoundState();
}

class _RecipesFoundState extends State<RecipesFound> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("RECIPEASY"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: widget.recipes.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.blueGrey[100],
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
              child: Column(
                children: <Widget>[
                  Text(widget.recipes[index]['title']),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      widget.recipes[index]['image'],
                    ),
                  )
                ],
              ),
            )
          );
        }
      )
    );
  }
}