import 'package:flutter/foundation.dart';
import 'package:library_app/db/db.dart';
import 'package:library_app/models/category_model.dart';

class CategoryProvider extends ChangeNotifier {
  List<CategoryModel> categories = [];
  final db = DatabaseHelper();

  CategoryProvider() {
    _loadCategories(); // ✅ Load categories on provider initialization
  }

  /// ✅ Fetch categories from DB and store them in `categories` list
  Future<void> _loadCategories() async {
    categories = await db.getAllCategories(); // Fetch all categories
    notifyListeners(); // Update UI when data is loaded
  }

  /// ✅ Insert a new category and update the list
  Future<int> insertCategory(CategoryModel category) async {
    final id = await db.insertCategory(category);
    if (id != -1) {
      categories.add(category);
      notifyListeners();
    }
    return id;
  }
}
