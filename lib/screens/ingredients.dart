import 'package:flutter/material.dart';

class IngredientsPage extends StatefulWidget {
  const IngredientsPage({Key key}) : super(key: key);
  @override
  _IngredientPageState createState() => _IngredientPageState();
}

class _IngredientPageState extends State<IngredientsPage>{

  Widget myInput(){
    return Container(
      width: 320,
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      child: TextField(
        autocorrect: true,
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
          ],
        ),
      ),
    );
  }
}