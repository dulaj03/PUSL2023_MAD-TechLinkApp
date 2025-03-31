import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:io';

class SocialPostCard extends StatefulWidget {
  final String profileImageUrl;
  final String userName;
  final String userTitle;
  final String postTime;
  final String postText;
  final List<String>? postImages;
  final int likeCount;
  final int commentCount;
  final bool isLiked;
  final bool isSaved;
  final Function()? onLikeTap;
  final Function()? onCommentTap;
  final Function()? onSaveTap;
  final Function()? onProfileTap;

  const SocialPostCard({
    super.key,
    required this.profileImageUrl,
    required this.userName,
    required this.userTitle,
    required this.postTime,
    required this.postText,
    this.postImages,
    this.likeCount = 0,
    this.commentCount = 0,
    this.isLiked = false,
    this.isSaved = false,
    this.onLikeTap,
    this.onCommentTap,
    this.onSaveTap,
    this.onProfileTap,
  });

  @override
  State<SocialPostCard> createState() => _SocialPostCardState();
}

class _SocialPostCardState extends State<SocialPostCard>
    with SingleTickerProviderStateMixin {
  late bool _isLiked;
  late bool _isSaved;
  late int _likeCount;
  final PageController _pageController = PageController();
  late AnimationController _animationController;
  bool _showHeart = false;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.isLiked;
    _isSaved = widget.isSaved;
    _likeCount = widget.likeCount;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
  }

  void _handleLike() {
    setState(() {
      if (_isLiked) {
        _likeCount--;
      } else {
        _likeCount++;
        _showHeart = true;
        _animationController.forward(from: 0.0).then((_) {
          setState(() {
            _showHeart = false;
          });
        });
      }
      _isLiked = !_isLiked;
    });

    if (widget.onLikeTap != null) {
      widget.onLikeTap!();
    }
  }

  void _handleSave() {
    setState(() {
      _isSaved = !_isSaved;
    });

    if (widget.onSaveTap != null) {
      widget.onSaveTap!();
    }
  }

  bool _isAssetPath(String path) {
    return path.startsWith('assets/');
  }

  bool _isNetworkPath(String path) {
    return path.startsWith('http://') || path.startsWith('https://');
  }

  Widget _getImageWidget(String imageUrl, {double? width, double? height}) {
    if (_isAssetPath(imageUrl)) {
      return Image.asset(
        imageUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
      );
    } else if (_isNetworkPath(imageUrl)) {
      return Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value:
                  loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
            ),
          );
        },
      );
    } else {
      return Image.file(
        File(imageUrl),
        width: width,
        height: height,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: widget.onProfileTap,
                  child: ClipOval(
                    child: _getImageWidget(
                      widget.profileImageUrl,
                      width: 48,
                      height: 48,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.userName,
                        style: GoogleFonts.chakraPetch(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        child: Text(
                          widget.userTitle,
                          style: GoogleFonts.chakraPetch(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.postTime,
                        style: GoogleFonts.chakraPetch(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              widget.postText,
              style: GoogleFonts.chakraPetch(
                fontSize: 16,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
          if (widget.postImages != null && widget.postImages!.isNotEmpty)
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                GestureDetector(
                  onDoubleTap: _handleLike,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 500,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: widget.postImages!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(horizontal: 1),
                              child: _getImageWidget(widget.postImages![index]),
                            );
                          },
                        ),
                      ),
                      if (_showHeart)
                        FadeTransition(
                          opacity: Tween<double>(begin: 2.0, end: 0.0).animate(
                            CurvedAnimation(
                              parent: _animationController,
                              curve: Curves.easeOut,
                            ),
                          ),
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 100,
                          ),
                        ),
                    ],
                  ),
                ),
                if (widget.postImages!.length > 1)
                  Positioned(
                    bottom: 8,
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: widget.postImages!.length,
                      effect: const WormEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        spacing: 8,
                        dotColor: Colors.grey,
                        activeDotColor: Color.fromARGB(255, 146, 227, 169),
                      ),
                    ),
                  ),
              ],
            ),

          Divider(height: 1, thickness: 1, color: Colors.grey[200]),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                  onPressed: _handleLike,
                  icon: Icon(
                    _isLiked ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
                    color:
                        _isLiked
                            ? const Color.fromARGB(255, 146, 227, 169)
                            : Colors.grey[700],
                  ),
                  label: Text(
                    'Like',
                    style: GoogleFonts.chakraPetch(
                      color:
                          _isLiked
                              ? const Color.fromARGB(255, 146, 227, 169)
                              : Colors.grey[700],
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),

                TextButton.icon(
                  onPressed: widget.onCommentTap,
                  icon: Icon(Icons.comment_outlined, color: Colors.grey[700]),
                  label: Text(
                    'Comment',
                    style: GoogleFonts.chakraPetch(color: Colors.grey[700]),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),

                TextButton.icon(
                  onPressed: _handleSave,
                  icon: Icon(
                    _isSaved ? Icons.bookmark : Icons.bookmark_border,
                    color: _isSaved ? Colors.black : Colors.grey[700],
                  ),
                  label: Text(
                    'Save',
                    style: GoogleFonts.chakraPetch(
                      color: _isSaved ? Colors.black : Colors.grey[700],
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
