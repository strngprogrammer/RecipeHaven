import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_haven/controllers/HomeController.dart';

HomeController _homeController = Get.find();

String GetDiet() {
  var query = "";
  var x = GetStorage().read("DietSettings");
  if (x['balanced']) {
    query += "&diet=balanced";
  }
  if (x['HighFiber']) {
    query += "&diet=high-fiber";
  }
  if (x['HighProtein']) {
    query += "&diet=high-protein";
  }
  if (x['LowCarb']) {
    query += "&diet=low-carb";
  }
  if (x['LowFat']) {
    query += "&diet=low-fat";
  }
  if (x['LowSodium']) {
    query += "&diet=low-sodium";
  }
  return query;
}

String GetHealth() {
  var query = "";
  var x = GetStorage().read("healthSettings");
  if (x['alcoholFree']) {
    query += "&health=alcohol-free";
  }
  if (x['eggFree']) {
    query += "&health=egg-free";
  }
  if (x['fishFre']) {
    query += "&health=fish-free";
  }
  if (x['glutenFree']) {
    query += "&health=gluten-free";
  }
  if (x['noOil']) {
    query += "&health=no-oil-added";
  }
  if (x['vegetarian']) {
    query += "&health=vegetarian";
  }
  return query;
}

Future<Map<dynamic, dynamic>> GetRecipes(String keyword) async {
  var url = Uri.parse(
      'https://api.edamam.com/api/recipes/v2?type=public&q=$keyword&app_id=253c3edc&app_key=4344d3401f66d8bbfe3548508eefd57e&ingr=8${GetDiet()}${GetHealth()}');
  var response =
      await http.get(url, headers: {'Content-Type': "application/json"});

  print(response.body);

  return jsonDecode(response.body);
}

Future<Map<dynamic, dynamic>> GetRecipesByUri(String uri) async {
  var url = Uri.parse(uri);
  var response =
      await http.get(url, headers: {'Content-Type': "application/json"});

  print(response.body);

  return jsonDecode(response.body);
}

Future<Map<dynamic, dynamic>> GetRandomRecipes() async {
  var url = Uri.parse(
      'https://api.edamam.com/api/recipes/v2?random=true&type=public&app_id=253c3edc&app_key=4344d3401f66d8bbfe3548508eefd57e&ingr=8${GetDiet()}${GetHealth()}');
  var response =
      await http.get(url, headers: {'Content-Type': "application/json"});

  print(response.body);

  return jsonDecode(response.body);
}
