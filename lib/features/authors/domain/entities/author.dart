class Author {
  final String id;
  final String name;
  final String? imageUrl;
  final DateTime createdAt;

  const Author({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.createdAt,
  });
}
