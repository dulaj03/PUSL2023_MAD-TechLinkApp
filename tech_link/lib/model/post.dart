class Post {
  final String profileImageUrl;
  final String userName;
  final String userTitle;
  final String postTime;
  final String postText;
  final int likeCount;
  final int commentCount;
  final List<String> postImages;

  Post({
    required this.profileImageUrl,
    required this.userName,
    required this.userTitle,
    required this.postTime,
    required this.postText,
    required this.likeCount,
    required this.commentCount,
    required this.postImages,
  });
}
