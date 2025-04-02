import 'package:tech_link/model/featured_post.dart';

class FeaturedPostsData {
  static List<FeaturedPostModel> getFeaturedPosts() {
    return [
      FeaturedPostModel(
        id: "1",
        title: "AI in Healthcare",
        description:
            "How artificial intelligence is revolutionizing medical diagnoses and treatment plans.",
        imagePath:
            "assets/Artificial-Intelligence-in-Healthcare-industry-scaled.jpg",
        likes: "342",
        comments: "28",
        date: "2 days ago",
        link: "https://example.com/ai-healthcare",
      ),
      FeaturedPostModel(
        id: "2",
        title: "Web3 Technologies",
        description:
            "Exploring the future of decentralized web applications and blockchain technology.",
        imagePath: "assets/Web3 compressed.jpg",
        likes: "189",
        comments: "15",
        date: "5 days ago",
        link: "https://example.com/web3-tech",
      ),
    ];
  }

  static FeaturedPostModel getFeaturedPostById(String id) {
    return getFeaturedPosts().firstWhere(
      (post) => post.id == id,
      orElse: () => throw Exception("Featured post not found"),
    );
  }
}
