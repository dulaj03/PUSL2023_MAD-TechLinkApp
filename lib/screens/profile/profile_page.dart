import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tech_link/data/featured_post.dart';
import 'package:tech_link/providers/user_provider.dart';
import 'package:tech_link/screens/add_post/add_post_page.dart';
import 'package:tech_link/widgets/edit_profile_dialog.dart';
import 'package:tech_link/widgets/featured_post_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void showEditProfileDialog() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final aboutText =
        "Lorem ipsum dolor sit amet..."; // Replace with actual user about text

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return EditProfileDialog(
          user: userProvider.user,
          aboutText: aboutText,
          onUpdate: (username, email, phone, about) {
            // Update user data
            // This is where you would call a method in your UserProvider to update the user data
            // Example: userProvider.updateUserProfile(username, email, phone, about);

            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Profile updated successfully'),
                backgroundColor: Color.fromARGB(255, 245, 146, 69),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    var screenSize = MediaQuery.of(context).size;
    final featuredPosts = FeaturedPostsData.getFeaturedPosts();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 250,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset(
                      "assets/coverphoto.jpg",
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 80,
                      left: 20,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                        ),
                        child: ClipOval(
                          child: SizedBox(
                            height: 150,
                            width: 150,
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/icon_bg_F.jpg',
                              image: userProvider.user!.profilePictureURL,
                              fit: BoxFit.cover,
                              imageErrorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.error);
                              },
                              placeholderFit: BoxFit.cover,
                              fadeInDuration: const Duration(milliseconds: 500),
                              fadeInCurve: Curves.easeIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 160,
                      right: 10,
                      child: IconButton(
                        onPressed: showEditProfileDialog,
                        icon: const Icon(Icons.edit_outlined),
                        iconSize: 30,
                        color: const Color.fromARGB(255, 7, 59, 58),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userProvider.user!.username,
                      style: GoogleFonts.chakraPetch(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width / 1.35,
                      child: Text(
                        userProvider.user!.email,
                        style: GoogleFonts.chakraPetch(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: screenSize.width / 1.35,
                      child: Text(
                        "bio here bio here bio here bio here bio here bio here bio here",
                        style: GoogleFonts.chakraPetch(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),

                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Activity",
                          style: GoogleFonts.chakraPetch(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddPostPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 146, 227, 169),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                          child: Text(
                            'Create a Post',
                            style: GoogleFonts.chakraPetch(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Posts",
                              style: GoogleFonts.chakraPetch(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "12",
                              style: GoogleFonts.chakraPetch(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Followers",
                              style: GoogleFonts.chakraPetch(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "1.2k",
                              style: GoogleFonts.chakraPetch(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Following",
                              style: GoogleFonts.chakraPetch(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "1.5k",
                              style: GoogleFonts.chakraPetch(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "About",
                      style: GoogleFonts.chakraPetch(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width,
                      child: Text(
                        "I am a passionate Software Engineer specializing in AI-driven tech solutions, mobile and web development, and cloud computing. I am also a tech enthusiast and a lifelong learner.",
                        style: GoogleFonts.chakraPetch(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        //textAlign: TextAlign.justify,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Featured",
                      style: GoogleFonts.chakraPetch(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 235,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: featuredPosts.length,
                        itemBuilder: (context, index) {
                          return FeaturedPostCard(post: featuredPosts[index]);
                        },
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<UserProvider>().logout();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Colors.redAccent, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                        child: Text(
                          'Logout',
                          style: GoogleFonts.chakraPetch(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 45),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
