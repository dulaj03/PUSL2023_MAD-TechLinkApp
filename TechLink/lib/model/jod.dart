class Job {
  final String id;
  final String title;
  final String company;
  final String location;
  final String salary;
  final String description;
  final String imageUrl;
  final List<String> tags;
  final DateTime postedDate;
  final bool? isSaved;

  Job({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.description,
    required this.imageUrl,
    required this.tags,
    required this.postedDate,
    this.isSaved,
  });
}
