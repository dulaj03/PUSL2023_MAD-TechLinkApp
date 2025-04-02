class PodcastModel {
  final String id;
  final String title;
  final String host;
  final String description;
  final String youtubeVideoUrl;
  final String imagePath;
  final List<String> topics;
  final List<String> episodes;
  final String duration;
  final String rating;
  final String listenCount;

  PodcastModel({
    required this.id,
    required this.title,
    required this.host,
    required this.description,
    required this.youtubeVideoUrl,
    required this.imagePath,
    required this.topics,
    required this.episodes,
    required this.duration,
    required this.rating,
    required this.listenCount,
  });
}
