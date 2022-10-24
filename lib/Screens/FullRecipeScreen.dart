import 'package:flutter/material.dart';
import 'package:unismart/Screens/RecipesScreen.dart';

class FullRecipeScreen extends StatefulWidget {
  String recipe;
  String duration;
  String serves;
  String method;
  String ingredient;

  FullRecipeScreen({
    required this.recipe,
    required this.duration,
    required this.method,
    required this.serves,
    required this.ingredient,
  });

  @override
  State<FullRecipeScreen> createState() =>
      _FullRecipeScreenState(recipe, duration, serves, method, ingredient);
}

class _FullRecipeScreenState extends State<FullRecipeScreen> {
  late String recipe;
  late String duration;
  late String serves;
  late String method;
  late String ingredient;
  _FullRecipeScreenState(
      this.recipe, this.duration, this.serves, this.method, this.ingredient);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("${recipe}"),
          backgroundColor: Colors.blueGrey,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Center(
            child: Card(
                child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              child: Text("Method: ${method}   ",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              child: Text("Ingredients: ${ingredient}   ",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ))));
  }
}
