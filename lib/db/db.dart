import 'package:library_app/models/category_model.dart';
import 'package:path/path.dart' as P;
import 'package:sqflite/sqflite.dart';

const int DB_VERSION = 1;
const String DB_NAME = 'library.db';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _database;

  Future<Database> _openDb() async {
    final root = await getDatabasesPath();
    final dbPath = P.join(root, DB_NAME);

    _database = await openDatabase(
      dbPath,
      version: DB_VERSION,
      onCreate: (db, version) async {
        await db.execute(_createTableCategory);
      },
    );

    return _database!;
  }

  final String _createTableCategory = '''
  CREATE TABLE $tableCategory (
    $tblCategoryId INTEGER PRIMARY KEY AUTOINCREMENT,
    $tblCategoryName TEXT NOT NULL UNIQUE, 
    $tblCategoryDescription TEXT NOT NULL,
    $tblCategoryCreatedAt TEXT DEFAULT CURRENT_TIMESTAMP,  
    $tblCategoryUpdatedAt TEXT DEFAULT CURRENT_TIMESTAMP  
  );

  -- ✅ TRIGGER: Automatically update 'updatedAt' on modification
  CREATE TRIGGER update_category_updatedAt
  AFTER UPDATE ON $tableCategory
  FOR EACH ROW
  BEGIN
    UPDATE $tableCategory SET $tblCategoryUpdatedAt = CURRENT_TIMESTAMP
    WHERE $tblCategoryId = OLD.$tblCategoryId;
  END;
''';

  /// ✅ Public method to insert default categories **only if the table is empty**
  Future<void> ensureDefaultCategories() async {
    final db = await _openDb();
    final count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $tableCategory'));

    if (count == 0) {
      // ✅ Insert only if no categories exist
      List<CategoryModel> defaultCategories = [
        CategoryModel(name: "Fiction", description: "Imaginary stories"),
        CategoryModel(name: "Non-Fiction", description: "Based on real events"),
        CategoryModel(
            name: "Science Fiction", description: "Futuristic concepts"),
        CategoryModel(name: "Fantasy", description: "Magic and mythology"),
        CategoryModel(
            name: "Mystery", description: "Crime and detective stories"),
        CategoryModel(name: "Thriller", description: "Suspense and excitement"),
        CategoryModel(name: "Romance", description: "Love and relationships"),
        CategoryModel(name: "History", description: "Historical records"),
        CategoryModel(name: "Business", description: "Finance and management"),
        CategoryModel(name: "Self-Help", description: "Personal growth"),
      ];

      for (var category in defaultCategories) {
        await db.insert(tableCategory, category.toMap());
      }

      print("✅ Default categories inserted");
    } else {
      print("✅ Categories already exist, skipping insertion");
    }
  }

  /// ✅ Insert a new category (createdAt is automatic)
  Future<int> insertCategory(CategoryModel category) async {
    final db = await _openDb();
    try {
      final id = await db.insert(tableCategory, category.toMap(),
          conflictAlgorithm: ConflictAlgorithm.ignore);

      return id;
    } catch (e) {
      return -1; // -1 means duplicate or failed
    }
  }

  /// ✅ Get all categories
  Future<List<CategoryModel>> getAllCategories() async {
    final db = await _openDb();
    final List<Map<String, dynamic>> maps = await db.query(tableCategory);

    return maps.map((map) => CategoryModel.fromMap(map)).toList();
  }
}
