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
  static const String API_KEY = "e0847270afe348168a896fb1e496dbea";
  //static const String API_KEY ="c65b8ed1479f48b6b8300c5413968e82";

  Future<Map<String,dynamic>> randomRecipe(String tags) async{

    Map<String, String> parameters = {
      'apiKey': API_KEY,
      'tags' : tags,
    };

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
//      recipe.forEach((k,v) => print('${k}: ${v}'));
      return recipe;
    } catch (err) {
      //If our response has error, we throw an error message
      throw err.toString();
    }
  }

  Future<Map<String,dynamic>> findRecipe(String input) async {

    Map<String, String> parameters = {
      'apiKey': API_KEY,
      'query': input,
      'number': '3',
    };

    Uri uri = Uri.https(
      _baseURL,
      '/recipes/search',
      parameters,
    );

//    print(uri);

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      var response = await http.get(uri,headers: headers);
      var results = json.decode(response.body);
//      print(results);
//      print(results['results'].length);
//      result.forEach((k) => print('${k}'));
      return results;
    } catch (err) {
      throw err.toSring();
    }
  }

  Future<List<dynamic>> recipeByIngr(String ingr) async{

    Map<String, String> parameters = {
      'apiKey': API_KEY,
      'ingredients': ingr,
      'number' : '4',
    };

    Uri uri = Uri.https(
      _baseURL,
      '/recipes/findByIngredients',
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
//      recipe.forEach((k,v) => print('${k}: ${v}'));
      return recipe;
    } catch (err) {
      //If our response has error, we throw an error message
      throw err.toString();
    }
  }

  Future<String> retrieveUrl(int id) async{
    Map<String, String> parameters = {
      'apiKey': API_KEY,
    };

    Uri uri = Uri.https(
      _baseURL,
      '/recipes/${id}/information',
      parameters,
    );

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      //http.get to retrieve the response
      var response = await http.get(uri,headers: headers);
      //decode the body of the response into a map
      var result = json.decode(response.body);
//      result.forEach((k,v) => print('${k}: ${v}'));

      return result['sourceUrl'];
    } catch (err) {
      //If our response has error, we throw an error message
      throw err.toString();
    }
  }

  Future<String> retrieveTitle(int id) async{
    Map<String, String> parameters = {
      'apiKey': API_KEY,
    };

    Uri uri = Uri.https(
      _baseURL,
      '/recipes/${id}/information',
      parameters,
    );

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      //http.get to retrieve the response
      var response = await http.get(uri,headers: headers);
      //decode the body of the response into a map
      var result = json.decode(response.body);
      return result['title'];
    } catch (err) {
      //If our response has error, we throw an error message
      throw err.toString();
    }
  }

  Future<Map<String,dynamic>> retrieveNF(int id) async{
    Map<String, String> parameters = {
      'apiKey': API_KEY,
    };

    Uri uri = Uri.https(
      _baseURL,
      '/recipes/${id}/nutritionWidget.json',
      parameters,
    );

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      //http.get to retrieve the response
      var response = await http.get(uri,headers: headers);
      //decode the body of the response into a map
      var result = json.decode(response.body);
      return result;
    } catch (err) {
      //If our response has error, we throw an error message
      throw err.toString();
    }
  }
}


