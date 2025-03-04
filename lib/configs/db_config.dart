import 'package:library_app/models/book_model.dart';
import 'package:library_app/models/category_model.dart';

final String createTableCategory = '''
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

final String createTableBook = '''
  CREATE TABLE $tableBook (
    $tblBookId INTEGER PRIMARY KEY AUTOINCREMENT,
    $tblBookName TEXT NOT NULL,
    $tblBookDescription TEXT NOT NULL,
    $tblBookCategoryId INTEGER NOT NULL,
    $tblBookAuther TEXT,  
    $tblBookRating INTEGER NOT NULL,
    $tblImage BLOB,
    $tblBookCreatedAt TEXT DEFAULT CURRENT_TIMESTAMP,
    $tblBookUpdatedAt TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ($tblBookCategoryId) REFERENCES $tableCategory ($tblCategoryId) ON DELETE CASCADE
  );
''';
