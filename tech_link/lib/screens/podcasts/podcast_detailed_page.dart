import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_link/data/podcasts.dart';
import 'package:tech_link/model/podcast.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PodcastDetailsPage extends StatefulWidget {
  final String podcastId;

  const PodcastDetailsPage({super.key, required this.podcastId});

  @override
  State<PodcastDetailsPage> createState() => _PodcastDetailsPageState();
}

class _PodcastDetailsPageState extends State<PodcastDetailsPage> {
  late YoutubePlayerController _controller;
  late PodcastModel podcast;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    podcast = PodcastData.getPodcastById(widget.podcastId);

    final videoId = YoutubePlayer.convertUrlToId(podcast.youtubeVideoUrl);

    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        disableDragSeek: false,
        loop: false,
        enableCaption: true,
      ),
    )..addListener(_listener);
  }

  void _listener() {
    if (_isPlayerReady && mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          podcast.title,
          style: GoogleFonts.chakraPetch(
            fontWeight: FontWeight.w500,
            fontSize: 17,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: const Color.fromARGB(
                  255,
                  146,
                  227,
                  169,
                ),
                progressColors: const ProgressBarColors(
                  playedColor: Color.fromARGB(256, 144, 226, 169),
                  handleColor: Color.fromARGB(256, 144, 226, 169),
                ),
                onReady: () {
                  setState(() {
                    _isPlayerReady = true;
                  });
                },
              ),
              builder: (context, player) {
                return Column(children: [player]);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    podcast.title,
                    style: GoogleFonts.chakraPetch(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Hosted by ${podcast.host}",
                    style: GoogleFonts.chakraPetch(
                      fontSize: 16,
                      color: Colors.lightgrey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  // Stats row
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color.fromARGB(256, 144, 226, 169),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        podcast.rating,
                        style: GoogleFonts.chakraPetch(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Icon(
                        Icons.headphones,
                        color: Color.fromARGB(256, 144, 226, 169),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        podcast.listenCount,
                        style: GoogleFonts.chakraPetch(fontSize: 16),
                      ),
                      const SizedBox(width: 20),
                      const Icon(
                        Icons.access_time,
                        color: Color.fromARGB(256, 144, 226, 169),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        podcast.duration,
                        style: GoogleFonts.chakraPetch(fontSize: 16),
                      ),
                    ],
                  ),

                  // Topics
                  const SizedBox(height: 16),
                  Text(
                    "Topics",
                    style: GoogleFonts.chakraPetch(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        podcast.topics.map((topic) {
                          return Chip(
                            label: Text(
                              topic,
                              style: GoogleFonts.chakraPetch(
                                color: Colors.black,
                              ),
                            ),
                            backgroundColor: Color.fromARGB(256, 144, 226, 169),
                            padding: const EdgeInsets.all(0),
                          );
                        }).toList(),
                  ),

                  const SizedBox(height: 16),
                  Text(
                    "Description",
                    style: GoogleFonts.chakraPetch(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    podcast.description,
                    style: GoogleFonts.chakraPetch(fontSize: 16, height: 1.5),
                  ),

                  const SizedBox(height: 24),
                  Text(
                    "Episodes",
                    style: GoogleFonts.chakraPetch(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: podcast.episodes.length,
                    itemBuilder: (context, index) {
                      final episode = podcast.episodes[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundColor: Color.fromARGB(256, 144, 226, 169),
                          child: Text(
                            "${index + 1}",
                            style: GoogleFonts.chakraPetch(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          episode,
                          style: GoogleFonts.chakraPetch(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.play_circle_outline,
                          color: Color.fromARGB(256, 144, 226, 169),
                        ),
                        onTap: () {
                          if (_isPlayerReady) {
                            _controller.seekTo(Duration.zero);
                            _controller.play();
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
