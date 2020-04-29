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

  Future<Map<String,dynamic>> randomRecipe() async{
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
      var response = await http.get(uri,headers: headers);
      //decode the body of the response into a map
      var recipe = json.decode(response.body);
      recipe = recipe['recipes'][0];
      recipe.forEach((k,v) => print('${k}: ${v}'));
      return recipe;
    } catch (err) {
      //If our response has error, we throw an error message
      throw err.toString();
    }
  }

  Future<Map<String,dynamic>> findRecipe() async {
    Uri uri = Uri.https(
      _baseURL,
      '/recipes/search',
      parameters,
    );

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      var response = await http.get(uri,headers: headers);
      var recipe = json.decode(response.body);
      recipe = recipe['recipes'][0];
      recipe.forEach((k,v) => print('${k}: ${v}'));
      return recipe;
    } catch (err) {
      throw err.toSring();
    }
  }
}