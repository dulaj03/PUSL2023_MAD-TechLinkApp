import 'package:flutter/material.dart';
import 'package:tech_link/model/post.dart';

class PostProvider extends ChangeNotifier {
  List<Post> posts = [
    Post(
      profileImageUrl:
          "assets/WhatsApp Image 2024-07-12 at 12.43.14_eab6b053.jpg",
      userName: "Kasun Karunanayake",
      userTitle: "Intern Software Engineer at ION Groups",
      postTime: "2h ago",
      postText:
          "Nvidia Corporation is an American multinational corporation. Headquartered in Santa Clara, and California",
      likeCount: 48,
      commentCount: 21,
      postImages: ["assets/p2.1.jpg", "assets/p2.2.jpg"],
    ),
    Post(
      profileImageUrl: "assets/profile.jpg",
      userName: "Kavya Samaraweera",
      userTitle: "Senior Security Engineer at Tech Co.",
      postTime: "3h ago",
      postText:
          "Security Engineers designs, implements, and maintains cybersecurity solutions to protect an organization's data and systems from unauthorized access, cyberattacks, and other threats.",
      likeCount: 42,
      commentCount: 8,
      postImages: ["assets/p1.jpg"],
    ),
    Post(
      profileImageUrl: "assets/profile3.jpg",
      userName: "Tharusha Perera",
      userTitle: "Senior Software Engineer WaveLoop (pvt) ltd",
      postTime: "3h ago",
      postText:
          "We are hiring Graphic Designers, Content Managers, and Copywriters",
      likeCount: 42,
      commentCount: 8,
      postImages: ["assets/job3.2.jpg", "assets/job3.jpg"],
    ),
  ];

  void addPost(Post newPost) {
    posts.add(newPost);
    notifyListeners();
  }
}
