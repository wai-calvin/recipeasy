import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:recipeasy/model/recipe_model.dart';


class ApiService {
  //The API service will be a singleton, therefore create a private constructor
  //ApiService._instantiate(), and a static instance variable
  ApiService._instantiate();
  static final ApiService instance = ApiService._instantiate();


  //Add base URL for the spoonacular API, endpoint and API Key as a constant
  final String _baseURL = "api.spoonacular.com";
  static const String API_KEY ="c65b8ed1479f48b6b8300c5413968e82";

  Map<String, String> parameters = {
    'apiKey': API_KEY,
  };

  void randomRecipe() async{
    Uri uri = Uri.https(
      _baseURL,
      '/recipes/random',
      parameters,
    );

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      //http.get to retrieve the response
      print(uri);
      var response = await http.get(uri,headers: headers);
      //decode the body of the response into a map
      Map<String,dynamic> recipe = json.decode(response.body);
      print(recipe.runtimeType);
      print(recipe);
    } catch (err) {
      //If our response has error, we throw an error message
      throw err.toString();
    }
  }
}