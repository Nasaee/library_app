import 'package:flutter/foundation.dart';
import 'package:library_app/db/db.dart';
import 'package:library_app/models/book_model.dart';

class BookProvider extends ChangeNotifier {
  List<BookModel> books = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  /// ✅ **Insert a new book into the database**
  Future<int> insertBook(BookModel book) async {
    final id = await _dbHelper.insertBook(book);
    if (id > 0) {
      books.add(book);
      notifyListeners();
    }
    return id;
  }

  /// ✅ **Fetch all books from the database**
  Future<void> fetchBooks() async {
    final fetchedBooks = await _dbHelper.getAllBooks();
    books = fetchedBooks;
    notifyListeners();
  }

  /// ✅ **Delete a book by ID**
  Future<void> deleteBook(int bookId) async {
    await _dbHelper.deleteBook(bookId);
    books.removeWhere((book) => book.id == bookId);
    notifyListeners();
  }
}
