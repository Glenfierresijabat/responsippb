import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import 'add_recipe_screen.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Map<String, dynamic> recipe;
  final Function onRecipeUpdated;

  RecipeDetailScreen({required this.recipe, required this.onRecipeUpdated});

  void _deleteRecipe(BuildContext context) async {
    await DatabaseHelper.instance.delete(recipe['id']);
    onRecipeUpdated();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe['name']),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddRecipeScreen(recipe: recipe),
                ),
              ).then((_) => onRecipeUpdated());
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _deleteRecipe(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Resep',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(recipe['name']),
            SizedBox(height: 16),
            Text(
              'Waktu Persiapan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(recipe['preparation_time']),
            SizedBox(height: 16),
            Text(
              'Bahan-bahan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(recipe['ingredients']),
            SizedBox(height: 16),
            Text(
              'Langkah-langkah',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(recipe['instructions']),
          ],
        ),
      ),
    );
  }
}
