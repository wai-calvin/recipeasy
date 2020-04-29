import 'package:flutter/material.dart';

class IngredientsPage extends StatefulWidget {
  const IngredientsPage({Key key}) : super(key: key);
  @override
  _IngredientPageState createState() => _IngredientPageState();
}

class _IngredientPageState extends State<IngredientsPage>{
  List<String> _ingredients = [];

  final myController = TextEditingController();
  ScrollController _scrollController = new ScrollController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  Widget myInput(){
    return Container(
      width: 340,
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
          return ListTile(
              title: Text(_ingredients[index]),
              onTap: () => _removeIngredientPrompt(index),
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

  void _removeIngredientPrompt(int index) {
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

  void _removeIngredient(int index) {
    setState(() => _ingredients.removeAt(index));
  }

  void _getRecipeByIngr(BuildContext context){

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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          _getRecipeByIngr(context);
        },
        label: Text('Get Recipe By Ingredients'),
      ),
    );
  }
}