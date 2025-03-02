import 'package:library_app/models/category_model.dart';
import 'package:path/path.dart' as P;
import 'package:sqflite/sqflite.dart';

const int DB_VERSION = 1;
const String DB_NAME = 'library.db';

class DatabaseHelper {
  final String _createTableCategory = '''
    CREATE TABLE $tableCategory (
      $tblCategoryId INTEGER PRIMARY KEY AUTOINCREMENT,
      $tblCategoryName TEXT NOT NULL,
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

  Future<Database> _openDb() async {
    final root = await getDatabasesPath();
    final dbPath = P.join(root, DB_NAME);

    final db = await openDatabase(
      dbPath,
      version: DB_VERSION,
      onCreate: (db, version) async {
        await db.execute(_createTableCategory);
      },
    );

    return db;
  }

  // Insert new category (createdAt is automatic)
  Future<int> insertCategory(CategoryModel category) async {
    final db = await _openDb();
    final id = await db.insert(tableCategory, category.toMap());
    await db.close();
    return id;
  }

  // Update category (updatedAt updates automatically)
  Future<int> updateCategory(int categoryId, CategoryModel category) async {
    final db = await _openDb();
    final categoryMap = category.toMap()
      ..remove(tblCategoryCreatedAt) // ✅ Prevent overriding createdAt
      ..remove(tblCategoryUpdatedAt); // ✅ Let SQLite trigger handle updatedAt

    final result = await db.update(
      tableCategory,
      categoryMap,
      where: '$tblCategoryId = ?',
      whereArgs: [categoryId],
    );

    await db.close();
    return result;
  }

  Future<List<CategoryModel>> getAllCategories() async {
    final db = await _openDb();
    final List<Map<String, dynamic>> maps = await db.query(tableCategory);
    await db.close();

    return maps.map((map) => CategoryModel.fromMap(map)).toList();
  }
}
