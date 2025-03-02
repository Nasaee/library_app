const String tableCategory = 'categories';
const String tblCategoryId = 'id';
const String tblCategoryName = 'name';
const String tblCategoryDescription = 'description';
const String tblCategoryCreatedAt = 'createdAt';
const String tblCategoryUpdatedAt = 'updatedAt';

class CategoryModel {
  final int id;
  final String name;
  final String description;
  final DateTime? createdAt; // Nullable because SQLite sets it
  final DateTime? updatedAt; // Nullable because SQLite updates it

  CategoryModel({
    this.id = -1,
    required this.name,
    required this.description,
    this.createdAt, // Not required when creating a category
    this.updatedAt, // Not required when creating a category
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != -1) tblCategoryId: id, // ✅ Include only if updating
      tblCategoryName: name,
      tblCategoryDescription: description,
    };
  }

  // Convert SQLite Map to `CategoryModel`
  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map[tblCategoryId] as int,
      name: map[tblCategoryName] as String,
      description: map[tblCategoryDescription] as String,
      createdAt: map[tblCategoryCreatedAt] != null
          ? DateTime.parse(
              map[tblCategoryCreatedAt] as String) // ✅ Fetch from SQLite
          : null,
      updatedAt: map[tblCategoryUpdatedAt] != null
          ? DateTime.parse(
              map[tblCategoryUpdatedAt] as String) // ✅ Fetch from SQLite
          : null,
    );
  }
}
