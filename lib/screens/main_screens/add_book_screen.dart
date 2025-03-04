import 'package:flutter/material.dart';
import 'package:library_app/components/input.dart';
import 'package:library_app/models/category_model.dart';
import 'package:library_app/providers/category_provider.dart';
import 'package:provider/provider.dart';

class AddBookScreen extends StatefulWidget {
  static const String routeName = '/add';
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCategory;
  bool _submitted = false;
  int _rating = 0;
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: _submitted
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled, // ✅ Show validation after submit
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          padding: const EdgeInsets.all(10),
                          onPressed: () {},
                          icon:
                              const Icon(Icons.add_a_photo_outlined, size: 30),
                        ),
                        const Text('Add a photo'),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  // ⭐ Rating System
                  Column(
                    children: [
                      Row(
                        children: [
                          for (int i = 1; i <= 5; i++)
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _rating = i;
                                });
                              },
                              icon: Icon(
                                i <= _rating ? Icons.star : Icons.star_border,
                                color: Colors.amber,
                                size: 30,
                              ),
                            ),
                        ],
                      ),
                      if (_rating == 0 && _submitted)
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Please provide a rating',
                              style: TextStyle(color: Colors.red, fontSize: 12),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                    ],
                  ),

                  SizedBox(height: 16),

                  // 📖 Book Name Input
                  CustomTextInput(
                    label: 'Book Name',
                    hint: 'Enter book name',
                    controller: _nameController,
                    onChanged: () => setState(() {}),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Book name cannot be empty'
                        : null,
                  ),

                  const SizedBox(height: 8),

                  // 📝 Book Description Input
                  CustomTextInput(
                    label: 'Description',
                    hint: 'Enter book description',
                    controller: _descriptionController,
                    maxLines: 5,
                    onChanged: () => setState(() {}),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Description cannot be empty'
                        : null,
                  ),

                  const SizedBox(height: 8),

                  // 📌 Category Dropdown with Validation
                  const Text(
                    'Category',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    hint: const Text('Select a category'),
                    isExpanded: true,
                    items: categoryProvider.categories
                        .map((CategoryModel category) {
                      return DropdownMenuItem(
                        value: category.name,
                        child: Text(category.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Please select a category' : null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorText: _submitted && _selectedCategory == null
                          ? 'Please select a category'
                          : null, // ✅ Show error after submit
                    ),
                  ),

                  const SizedBox(height: 24),

                  // 🚀 Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _saveBook,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber[700],
                      ),
                      child: const Text('Save',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// ✅ Validate and Save Book
  void _saveBook() {
    setState(() {
      _submitted = true; // ✅ Show validation on submit
    });

    if (_formKey.currentState!.validate() && _selectedCategory != null ||
        _rating > 0) {
      print(
          '✅ Book Saved: Name - ${_nameController.text}, Category - $_selectedCategory, Rating - $_rating');
      _resetForm();
    }
  }

  /// ✅ Reset form fields after successful book addition
  void _resetForm() {
    _nameController.clear();
    _descriptionController.clear();
    setState(() {
      _submitted = false;
      _selectedCategory = null;
      _rating = 0;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
