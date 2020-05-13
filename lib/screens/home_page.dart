import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recipeasy/services/api_services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  Future<List> loadRecentlyViewed() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> myList = (prefs.getStringList('mylist') ?? List<String>());
    var recipes = [];
    for(int i = 0; i < myList.length; i++) {
       var result = await ApiService.instance.retrieveRecipe(myList[i]);
       recipes.add(result);
    }
    return recipes;
  }

  void goToRecipe(int id) async{
    var url = await ApiService.instance.retrieveUrl(id);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ViewRecipe(url: url)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recently Viewed"),
        centerTitle: true,
      ),
      body: Container(
          child: FutureBuilder<List>(
            future: loadRecentlyViewed(),
            builder: (context, AsyncSnapshot snapshot){
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                  itemCount: snapshot == null ? 0 : snapshot.data.length,
                  itemBuilder: (context, index) {
                    var recipe = snapshot.data[index];
                    return Container(
                        color: Colors.blueGrey[100],
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: InkWell(
                          onTap: () {goToRecipe(recipe['id']);},
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(5, 7, 5, 10),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  recipe['title'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image.network(
                                    recipe['image'],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                    );
                  }
              );
            },
          )
      )
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