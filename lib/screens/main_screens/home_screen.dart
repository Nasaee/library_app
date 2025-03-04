import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Background color
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 📌 Top App Bar
              _buildAppBar(),

              const SizedBox(height: 16),

              // 📌 Book Categories
              // Expanded(
              //   child: SingleChildScrollView(
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         _buildCategorySection("Poetry", poetryBooks),
              //         const SizedBox(height: 16),
              //         _buildCategorySection("Romance", romanceBooks),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  /// ✅ **App Bar with Logo & Profile Picture**
  Widget _buildAppBar() {
    return Row(
      children: [
        Icon(Icons.menu_book_outlined, color: Colors.amber[800], size: 32),
        const SizedBox(width: 8),
        SizedBox(
          width: 8,
        ),
        const Text(
          "Albrain Books",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  /// ✅ **Category Section with Horizontal Scroll**
  Widget _buildCategorySection(String title, List<Book> books) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.amber[800]),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 250, // Fixed height for horizontal scrolling
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: books.length,
            itemBuilder: (context, index) {
              return _buildBookCard(books[index]);
            },
          ),
        ),
      ],
    );
  }

  /// ✅ **Book Card UI**
  Widget _buildBookCard(Book book) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Book Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.network(
              book.imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  book.author,
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < book.rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 16,
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// **📚 Sample Data Model for Books**
class Book {
  final String title;
  final String author;
  final String imageUrl;
  final int rating;

  Book(
      {required this.title,
      required this.author,
      required this.imageUrl,
      required this.rating});
}

/// **📚 Dummy Data for Books**
List<Book> poetryBooks = [
  Book(
    title: "Prisoner",
    author: "Arnod Miller",
    imageUrl: "https://m.media-amazon.com/images/I/41pbnOmKvAL.jpg",
    rating: 4,
  ),
  Book(
    title: "The Words I Cannot Say",
    author: "Smith Brooks",
    imageUrl: "https://m.media-amazon.com/images/I/41Z3RlZPSSL.jpg",
    rating: 5,
  ),
];

List<Book> romanceBooks = [
  Book(
    title: "Meet You",
    author: "Bill Silas",
    imageUrl: "https://m.media-amazon.com/images/I/41wtrJYm4cL.jpg",
    rating: 4,
  ),
  Book(
    title: "Moonstruck",
    author: "Amber Love",
    imageUrl: "https://m.media-amazon.com/images/I/41wRzSLpyqL.jpg",
    rating: 5,
  ),
];
