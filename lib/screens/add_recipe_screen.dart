import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class AddRecipeScreen extends StatefulWidget {
  final Map<String, dynamic>? recipe;

  AddRecipeScreen({this.recipe});

  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _ingredientsController = TextEditingController();
  TextEditingController _instructionsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.recipe != null) {
      _nameController.text = widget.recipe!['name'];
      _timeController.text = widget.recipe!['preparation_time'];
      _ingredientsController.text = widget.recipe!['ingredients'];
      _instructionsController.text = widget.recipe!['instructions'];
    }
  }

  void _saveRecipe() async {
    if (_formKey.currentState!.validate()) {
      final recipe = {
        'name': _nameController.text,
        'preparation_time': _timeController.text,
        'ingredients': _ingredientsController.text,
        'instructions': _instructionsController.text,
      };

      if (widget.recipe != null) {
        recipe['id'] = widget.recipe!['id'];
        await DatabaseHelper.instance.update(recipe);
      } else {
        await DatabaseHelper.instance.insert(recipe);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.recipe == null ? 'Tambah Resep' : 'Edit Resep')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nama Resep'),
                validator: (value) => value!.isEmpty ? 'Masukkan nama resep' : null,
              ),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(labelText: 'Waktu Persiapan'),
                validator: (value) => value!.isEmpty ? 'Masukkan waktu persiapan' : null,
              ),
              TextFormField(
                controller: _ingredientsController,
                decoration: InputDecoration(labelText: 'Bahan-bahan'),
              ),
              TextFormField(
                controller: _instructionsController,
                decoration: InputDecoration(labelText: 'Langkah-langkah'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveRecipe,
                child: Text('Simpan Resep'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
