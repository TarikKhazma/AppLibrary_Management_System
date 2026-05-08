class Author {
  final String id;
  final String name;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime? deletedAt;

  const Author({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.createdAt,
    this.deletedAt,
  });
}
