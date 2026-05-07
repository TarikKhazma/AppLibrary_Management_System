import '../../domain/entities/book.dart';

class BookModel extends Book {
  const BookModel({
    required super.id,
    required super.title,
    super.publishedYear,
    super.authorId,
    super.authorName,
    super.imageUrl,
    required super.createdAt,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        id: json['id'] as String,
        title: json['title'] as String,
        publishedYear: json['published_year'] as int?,
        authorId: json['author_id'] as String?,
        authorName: json['authors'] != null
            ? (json['authors'] as Map<String, dynamic>)['name'] as String?
            : null,
        imageUrl: json['image_url'] as String?,
        createdAt: DateTime.parse(json['created_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'published_year': publishedYear,
        'author_id': authorId,
        if (imageUrl != null && imageUrl!.isNotEmpty) 'image_url': imageUrl,
      };
}
