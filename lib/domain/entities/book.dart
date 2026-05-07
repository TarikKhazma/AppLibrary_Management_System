class Book {
  final String id;
  final String title;
  final int? publishedYear;
  final String? authorId;
  final String? authorName;
  final String? imageUrl;
  final DateTime createdAt;

  const Book({
    required this.id,
    required this.title,
    this.publishedYear,
    this.authorId,
    this.authorName,
    this.imageUrl,
    required this.createdAt,
  });
}
