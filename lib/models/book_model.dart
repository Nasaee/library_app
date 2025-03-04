import 'dart:typed_data';

const String tableBook = 'books';
const String tblBookId = 'id';
const String tblBookName = 'name';
const String tblBookDescription = 'description';
const String tblBookCategoryId = 'categoryId';
const String tblBookAuther = 'auther';
const String tblBookRating = 'rating';
const String tblImage = 'image';
const String tblBookCreatedAt = 'createdAt';
const String tblBookUpdatedAt = 'updatedAt';

class BookModel {
  final int id;
  final String name;
  final String description;
  final int categoryId;
  final String auther;
  final int rating;
  final Uint8List imageBlob;
  final DateTime? createdAt; // Nullable because SQLite sets it
  final DateTime? updatedAt; // Nullable because SQLite updates it

  BookModel({
    this.id = -1,
    required this.name,
    required this.description,
    required this.categoryId,
    this.auther = '',
    required this.rating,
    required this.imageBlob,
    this.createdAt, // Not required when creating a category
    this.updatedAt, // Not required when creating a category
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != -1) tblBookId: id, // ✅ Include only if updating
      tblBookName: name,
      tblBookDescription: description,
      tblBookCategoryId: categoryId,
      tblBookAuther: auther,
      tblBookRating: rating,
      tblImage: imageBlob,
    };
  }

  // Convert SQLite Map to `CategoryModel`
  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      id: map[tblBookId] as int,
      name: map[tblBookName] as String,
      description: map[tblBookDescription] as String,
      categoryId: map[tblBookCategoryId] as int,
      auther: map[tblBookAuther] as String,
      rating: map[tblBookRating] as int,
      imageBlob: map[tblImage] as Uint8List,
      createdAt: map[tblBookCreatedAt] != null
          ? DateTime.parse(
              map[tblBookCreatedAt] as String) // ✅ Fetch from SQLite
          : null,
      updatedAt: map[tblBookUpdatedAt] != null
          ? DateTime.parse(
              map[tblBookUpdatedAt] as String) // ✅ Fetch from SQLite
          : null,
    );
  }
}
