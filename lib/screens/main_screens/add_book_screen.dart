import 'package:flutter/material.dart';
import 'package:library_app/components/input.dart';

class AddBookScreen extends StatefulWidget {
  static const String routeName = '/add';
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>(); // ✅ Form key for validation
  int _rating = 0;
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey, // ✅ Wrap inside Form for validation
              child: Column(
                children: [
                  // 📷 Image Placeholder
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
                  const SizedBox(height: 8),

                  // ⭐ Rating System
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
                  if (_rating == 0 &&
                      _formKey.currentState != null &&
                      !_formKey.currentState!
                          .validate()) // ✅ Show validation message for rating
                    const SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Please select a rating',
                          style: TextStyle(color: Colors.red, fontSize: 14),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),

                  const SizedBox(height: 8),

                  // 📖 Book Name Input
                  CustomTextInput(
                    label: 'Name',
                    hint: 'Enter book\'s name',
                    controller: _nameController,
                    onChanged: () =>
                        setState(() {}), // ✅ Reset error when typing
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Book name cannot be empty';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 8),

                  // 📝 Book Description Input
                  CustomTextInput(
                    label: 'Description',
                    hint: 'Enter the description of the book',
                    controller: _descriptionController,
                    maxLines: 5,
                    onChanged: () =>
                        setState(() {}), // ✅ Reset error when typing
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Description cannot be empty';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 24),

                  // 🚀 Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[300],
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                                color: Colors.white, letterSpacing: 1),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber[700],
                          ),
                          onPressed: _saveBook,
                          child: const Text(
                            'Save',
                            style: TextStyle(
                                color: Colors.white, letterSpacing: 1),
                          ),
                        ),
                      ),
                    ],
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
    if (_formKey.currentState!.validate() && _rating > 0) {
      print('Book Saved: Name - ${_nameController.text}, Rating - $_rating');
    } else {
      setState(() {}); // Refresh UI to show validation errors
    }
  }

// Dispose controllers  when the widget is removed from the widget tree
  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
