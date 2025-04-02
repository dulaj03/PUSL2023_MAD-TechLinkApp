class FeaturedPostModel {
  final String id;
  final String title;
  final String description;
  final String imagePath;
  final String likes;
  final String comments;
  final String date;
  final String? link;

  FeaturedPostModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.likes,
    required this.comments,
    required this.date,
    this.link,
  });
}
