import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:library_app/components/input.dart';
import 'package:library_app/models/book_model.dart';
import 'package:library_app/models/category_model.dart';
import 'package:library_app/providers/book_provider.dart';
import 'package:library_app/providers/category_provider.dart';
import 'package:library_app/screens/main_screens/home_screen.dart';
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
  File? _selectedImage; // ✅ Store picked image
  Uint8List? _imageBytes; // ✅ Convert to bytes for database storage
  final ImagePicker _picker = ImagePicker();
  final _authorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final bookProvider = Provider.of<BookProvider>(context, listen: false);

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
                  // 📷 Image Picker
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                        image: _selectedImage != null
                            ? DecorationImage(
                                image: FileImage(_selectedImage!),
                                fit: BoxFit.cover)
                            : null,
                      ),
                      child: _selectedImage == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_a_photo_outlined, size: 30),
                                const Text('Tap to pick an image'),
                              ],
                            )
                          : null,
                    ),
                  ),
                  SizedBox(height: 16),
                  // ⭐ Rating System
                  Column(
                    children: [
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Rating',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
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
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.orange, // Change to desired color
                          width: 2.0,
                        ),
                      ),
                      errorText: _submitted && _selectedCategory == null
                          ? 'Please select a category'
                          : null, // ✅ Show error after submit
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ✍️ Author Input (Optional)
                  CustomTextInput(
                    label: 'Author (Optional)',
                    hint: 'Enter author name',
                    controller: _authorController,
                    onChanged: () => setState(() {}),
                    validator: (value) => null, // ✅ No validation required
                  ),

                  const SizedBox(height: 24),

                  // 🚀 Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _saveBook(bookProvider),
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

  /// ✅ Pick an image from the gallery
  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        _selectedImage = File(image.path);
        _imageBytes = bytes;
      });
    }
  }

  /// ✅ Validate and Save Book
  void _saveBook(BookProvider bookProvider) {
    setState(() {
      _submitted = true;
    });

    if (_formKey.currentState!.validate() &&
        _selectedCategory != null &&
        _rating > 0) {
      final book = BookModel(
        name: _nameController.text,
        description: _descriptionController.text,
        categoryId: 1, // Fetch categoryId properly
        auther: _authorController.text,
        rating: _rating,
        imageBlob: _imageBytes!,
      );

      bookProvider.insertBook(book).then((id) {
        if (id > 0) {
          _showToast('Book added successfully');
          context.goNamed(HomeScreen.routeName);
          _resetForm();
        }
      });
    }
  }

  /// ✅ Show toast message using `fluttertoast`
  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 14,
    );
  }

  /// ✅ Reset form fields after successful book addition
  void _resetForm() {
    _nameController.clear();
    _descriptionController.clear();
    setState(() {
      _submitted = false;
      _selectedCategory = null;
      _rating = 0;
      _selectedImage = null;
      _imageBytes = null;
      _authorController.clear();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
