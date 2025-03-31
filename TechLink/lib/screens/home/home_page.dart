import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tech_link/providers/post_provider.dart';
import 'package:tech_link/providers/user_provider.dart';
import 'package:tech_link/screens/add_post/add_post_page.dart';
import 'package:tech_link/screens/market_place/market_place_page_list.dart';
import 'package:tech_link/screens/podcasts/podcast_page.dart';
import 'package:tech_link/screens/profile/profile_page.dart';
import 'package:tech_link/screens/job_search/job_search_page.dart';
import 'package:tech_link/widgets/home/social_post_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;

  final List<IconData> iconList = [
    Icons.home,
    Icons.search,
    Icons.podcasts,
    Icons.person,
  ];

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      _buildHomeContent(),
      const SearchPage(),
      const PodcastPage(),
      const ProfilePage(),
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getUserInfo();
  }

  Future<void> _getUserInfo() async {
    if (context.read<UserProvider>().user == null) {
      await context.read<UserProvider>().getUserData();
    }
  }

  Widget _buildHomeContent() {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                final user = userProvider.user;
                return ClipOval(
                  child: SizedBox(
                    height: 48,
                    width: 48,
                    child:
                        user != null
                            ? FadeInImage.assetNetwork(
                              placeholder: 'assets/icon_bg_F.jpg',
                              image: user.profilePictureURL,
                              fit: BoxFit.cover,
                              imageErrorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.error);
                              },
                              placeholderFit: BoxFit.cover,
                              fadeInDuration: const Duration(milliseconds: 500),
                              fadeInCurve: Curves.easeIn,
                            )
                            : Image.asset(
                              'assets/icon_bg_F.jpg',
                              fit: BoxFit.cover,
                            ),
                  ),
                );
              },
            ),
            Text(
              "Tech Link",
              style: GoogleFonts.chakraPetch(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const MarketplacePage()),
                );
              },
              icon: const Icon(
                Icons.shopping_bag_outlined,
                size: 30,
                color: Colors.black,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Consumer<PostProvider>(
        builder: (context, postProvider, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: postProvider.posts.length,
                  itemBuilder: (context, index) {
                    final post = postProvider.posts[index];
                    return SocialPostCard(
                      profileImageUrl: post.profileImageUrl,
                      userName: post.userName,
                      userTitle: post.userTitle,
                      postTime: post.postTime,
                      postText: post.postText,
                      likeCount: 48,
                      commentCount: 21,
                      postImages: post.postImages,
                      onLikeTap: () {},
                      onCommentTap: () {},
                      onSaveTap: () {},
                      onProfileTap: () {},
                    );
                  },
                ),
                SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }

  void _handleNavigation(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final screenSize = MediaQuery.of(context).size;
    return userProvider.user == null
        ? Scaffold(
          body: Center(
            child: Column(
              spacing: 8,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/logo_full_T.png",
                  width: screenSize.width * 0.7,
                ),
                SizedBox(
                  width: screenSize.width * 0.65,
                  height: 4,
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(100),
                    color: Color.fromARGB(255, 7, 59, 58),
                  ),
                ),
              ],
            ),
          ),
        )
        : Scaffold(
          body: _pages[_bottomNavIndex],
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 146, 227, 169),
            shape: const CircleBorder(),
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (ctx) => const AddPostPage()));
            },
            elevation: 0,
            child: const Icon(
              Icons.add,
              color: Color.fromARGB(255, 7, 59, 58),
              size: 30,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar(
            icons: iconList,
            activeIndex: _bottomNavIndex,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.softEdge,
            onTap: _handleNavigation,
            activeColor: const Color.fromARGB(255, 146, 227, 169),
            inactiveColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 7, 59, 58),
            iconSize: 30,
            splashRadius: 0,
            splashColor: Colors.transparent,
          ),
        );
  }
}
