import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

class TattooSwipeScreen extends StatefulWidget {
  @override
  _TattooSwipeScreenState createState() => _TattooSwipeScreenState();
}

class _TattooSwipeScreenState extends State<TattooSwipeScreen> {
  List<TattooModel> tattooModels = []; // Liste des modèles de tatouages

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: TinderSwapCard(
            totalNum: tattooModels.length,
            cardBuilder: (context, index) => Card(
              child: Image.network(tattooModels[index].imageUrl),
            ),
            swipeCompleteCallback:
                (CardSwipeOrientation orientation, int index) {
              if (orientation == CardSwipeOrientation.RIGHT) {
                // Like
                likeTattoo(tattooModels[index]);
              } else if (orientation == CardSwipeOrientation.LEFT) {
                // Dislike
                dislikeTattoo(tattooModels[index]);
              } else if (orientation == CardSwipeOrientation.UP) {
                // Super Like
                superLikeTattoo(tattooModels[index]);
              }
            },
          ),
        ),
      ),
    );
  }

  void likeTattoo(TattooModel tattoo) {
    // Logique pour liker un tatouage
  }

  void dislikeTattoo(TattooModel tattoo) {
    // Logique pour disliker un tatouage
  }

  void superLikeTattoo(TattooModel tattoo) {
    // Logique pour super liker un tatouage et ouvrir la communication
  }
}

class TattooModel {
  final String id;
  final String imageUrl;
  final String artistId;

  TattooModel(
      {required this.id, required this.imageUrl, required this.artistId});
}
