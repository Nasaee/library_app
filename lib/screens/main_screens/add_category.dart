import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:library_app/constants/theme.dart';
import 'package:library_app/models/category_model.dart';
import 'package:library_app/providers/category_provider.dart';
import 'package:provider/provider.dart';

class AddCategoryScreen extends StatefulWidget {
  static const String routeName = '/category';
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _submitted = false;
  bool _isLoading = false; // ✅ Track loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Form(
            key: _formKey,
            autovalidateMode: _submitted
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ADD CATEGORY',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 24),

                // 📌 Name Input
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a category name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (_submitted) {
                      setState(() {});
                    }
                  },
                ),

                const SizedBox(height: 24),

                // 📌 Description Input
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Enter a description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.orange),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a category description';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (_submitted) {
                          setState(() {});
                        }
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // 📌 Submit Button with Loading Indicator
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.amber[800],
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _isLoading
                        ? null
                        : () {
                            setState(() {
                              _submitted = true;
                            });

                            if (_formKey.currentState!.validate()) {
                              _addCategory();
                            }
                          },
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('ADD'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  /// ✅ Insert category, show loading, disable button, reset fields on success
  void _addCategory() {
    final name = _nameController.text.trim();
    final description = _descriptionController.text.trim();

    setState(() {
      _isLoading = true;
    });

    Provider.of<CategoryProvider>(context, listen: false)
        .insertCategory(CategoryModel(name: name, description: description))
        .then((value) {
      if (value > 0) {
        _showToast('✅ Category added successfully'); // ✅ Show toast
        _resetForm();
      }
    }).catchError((error) {
      _showToast('❌ Error adding category: $error'); // ❌ Show error toast
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  /// ✅ Reset form fields after successful category addition
  void _resetForm() {
    _nameController.clear();
    _descriptionController.clear();
    setState(() {
      _submitted = false;
    });
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
}
