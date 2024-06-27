import 'package:flutter/material.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';
import 'package:tattoo_social_app/data/models/tattoo_model.dart';

class TattooSwipeScreen extends StatefulWidget {
  const TattooSwipeScreen({super.key});

  @override
  _TattooSwipeScreenState createState() => _TattooSwipeScreenState();
}

class _TattooSwipeScreenState extends State<TattooSwipeScreen> {
  List<TattooModel> tattooModels = []; // Liste des modèles de tatouages

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

  Widget _buildTattooCard(TattooModel tattoo) {
    return Card(
      child: Image.network(tattoo.imageUrl),
    );
  }

  void likeTattoo(TattooModel tattoo) {
    // Implement your logic for liking a tattoo
  }

  void dislikeTattoo(TattooModel tattoo) {
    // Implement your logic for disliking a tattoo
  }

  void superLikeTattoo(TattooModel tattoo) {
    // Implement your logic for super liking a tattoo and opening communication
  }
}
