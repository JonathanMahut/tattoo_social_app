import 'package:flutter/material.dart';
import 'package:tattoo_social_app/presentation/screens/tattoo_swipe_screen.dart';
import 'package:tattoo_social_app/presentation/widgets/custom_app_bar.dart';
import 'package:tattoo_social_app/presentation/widgets/post_card.dart';
import 'package:tattoo_social_app/presentation/widgets/story_bubble.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Explore'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Section for trending tattoos
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Trending Tattoos',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10, // Replace with actual data
                      itemBuilder: (context, index) => const PostCard(),
                    ),
                  ),
                ],
              ),
            ),

            // Section for tattoo artists
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Featured Tattoo Artists',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10, // Replace with actual data
                      itemBuilder: (context, index) => const StoryBubble(),
                    ),
                  ),
                ],
              ),
            ),

            // Section for tattoo swipe
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Find Your Next Tattoo',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TattooSwipeScreen(),
                        ),
                      );
                    },
                    child: const Text('Swipe Now'),
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
