import 'package:flutter/material.dart';
import 'package:tattoo_social_app/presentation/widgets/custom_app_bar.dart';
import 'package:tattoo_social_app/presentation/widgets/post_card.dart';
import 'package:tattoo_social_app/presentation/widgets/story_bubble.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Tatoo Connect'),
      body: ListView(
        children: [
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) => const StoryBubble(),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) => const PostCard(),
          ),
        ],
      ),
    );
  }
}
