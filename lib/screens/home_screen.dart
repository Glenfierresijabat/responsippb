import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import 'add_recipe_screen.dart';
import 'recipe_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _recipes = [];

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    final data = await DatabaseHelper.instance.queryAllRows();
    setState(() {
      _recipes = data;
    });
  }

  void _deleteRecipe(int id) async {
    await DatabaseHelper.instance.delete(id);
    _loadRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Resep')),
      body: ListView.builder(
        itemCount: _recipes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_recipes[index]['name']),
            subtitle: Text('Waktu: ${_recipes[index]['preparation_time']}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetailScreen(
                    recipe: _recipes[index],
                    onRecipeUpdated: _loadRecipes,
                  ),
                ),
              );
            },
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteRecipe(_recipes[index]['id']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddRecipeScreen()),
          );
          _loadRecipes();
        },
      ),
    );
  }
}
