import 'package:flutter/material.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';

class TattooSwipeScreen extends StatefulWidget {
  const TattooSwipeScreen({super.key});

  @override
  _TattooSwipeScreenState createState() => _TattooSwipeScreenState();
}

class _TattooSwipeScreenState extends State<TattooSwipeScreen> {
  List<Tattoo> tattooModels = []; // Liste des modèles de tatouages

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: SwipeableCardsSection(
            // Provide your list of TattooModel instances here
            items:
                tattooModels.map((tattoo) => _buildTattooCard(tattoo)).toList(),
            // Define swipe directions and corresponding actions
            onCardSwiped: (direction, index, widget) {
              if (direction == Direction.right) {
                likeTattoo(tattooModels[index]);
              } else if (direction == Direction.left) {
                dislikeTattoo(tattooModels[index]);
              } else if (direction == Direction.up) {
                superLikeTattoo(tattooModels[index]);
              } else if (direction == Direction.down) {
                // Handle swipe down action
                // Display details of Tatoo *model
              }
            },
            context: context,
          ),
        ),
      ),
    );
  }

  Widget _buildTattooCard(Tattoo tattoo) {
    return Card(
      child: Image.network(tattoo.imageUrl),
    );
  }

  void likeTattoo(Tattoo tattoo) {
    // Implement your logic for liking a tattoo
  }

  void dislikeTattoo(Tattoo tattoo) {
    // Implement your logic for disliking a tattoo
  }

  void superLikeTattoo(Tattoo tattoo) {
    // Implement your logic for super liking a tattoo and opening communication
  }
}
