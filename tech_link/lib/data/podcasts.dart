import 'package:tech_link/model/podcast.dart';

class PodcastData {
  static List<PodcastModel> getPodcasts() {
    return [
      PodcastModel(
        id: "1",
        title: "Hey ChatGPT, Summarize Google I/O",
        host: "WVFRM Podcast",
        description:
            "This was a week full of AI events! First, Marques gives a few thoughts on the new iPads since he missed last week and then Andrew and David bring him up to speed with all the weirdness that happened during Google I/O and the OpenAI event. Then we finish it all up with trivia. Enjoy!",
        youtubeVideoUrl: "https://youtu.be/5FI9XMigJsM?si=5wanLtP8KKi4g_lU",
        imagePath: "assets/wvfrm.jpg",
        topics: ["AI", "ChatGPT-4o", "Google I/O", "OpenAI event"],
        episodes: [
          "Marques iPad Thoughts",
          "OpenAI GPT-4o",
          "Google I/O Part 1",
          "Google I/O Part 2",
          "Outro and Trivia Quiz",
        ],
        duration: "114 min",
        rating: "4.9",
        listenCount: "602.2K",
      ),
      PodcastModel(
        id: "2",
        title: "An Unfiltered Conversation with Linus Tech Tips",
        host: "Colin and Samir",
        description:
            "In this episode, Colin and Samir are joined by Linus Sebastian, the host of Linus Tech Tips. Linus is a YouTuber with over 14 million subscribers and the founder of Linus Media Group. Linus is known for his unfiltered tech reviews and his ability to break down complex tech topics in a way that everyone can understand.",
        youtubeVideoUrl: "https://youtu.be/nmNzEf7dXsw?si=yx3XPwQb24mEEucI",
        imagePath: "assets/linus.png",
        topics: ["Life Experiences", "Inspire Creators", "Tech Ethics"],
        episodes: [
          "Linus's experience with YouTube burnout",
          "The future of Linus Tech Tips",
          "Linus's thoughts on the tech industry",
          "The impact of social media on mental health",
          "The importance of work-life balance",
        ],
        duration: "215 min",
        rating: "4.9",
        listenCount: "1.2M",
      ),
      PodcastModel(
        id: "3",
        title: "Falling in Love with Web Development",
        host: "Kyle Cook",
        description:
            "If you've gone on YouTube and searched how to get stuff done in web development, chances are you’ve come across Kyle Cook from web dev simplified. He's put up an incredible catalog of videos to simplify web development, for free. ",
        youtubeVideoUrl: "https://youtu.be/F7XGddoTxrA?si=0Cc8oWPhl9Sj29Ez",
        imagePath: "assets/kyle.jpg",
        topics: ["Web Development", "Career Growth", "Best Practices"],
        episodes: [
          "Kyle's journey to web dev",
          "Starting from scratch as developer",
          "How Kyle's YouTube channel came to be",
          "Kyle's favorite web dev tools",
        ],
        duration: "52 min",
        rating: "4.8",
        listenCount: "136.8K",
      ),
    ];
  }

  static PodcastModel getPodcastById(String id) {
    return getPodcasts().firstWhere(
      (podcast) => podcast.id == id,
      orElse: () => throw Exception("Podcast not found"),
    );
  }
}
