import 'package:card_keeper/data/models/pokemon_card.dart';
import 'package:card_keeper/widgets/card_ripple_flip_and_badges.dart';
import 'package:card_keeper/widgets/hero_widget.dart';
import 'package:flutter/material.dart';

class CardsGridView extends StatelessWidget {
  const CardsGridView({
    super.key,
    required this.appBarheight,
    required this.bottomTabHeight,
    required this.cardsList,
    this.cardLongPress,
    this.cardDoubleTap,
  });

  final double appBarheight;
  final double bottomTabHeight;
  final List<PokemonCard> cardsList;
  final void Function(PokemonCard? card)? cardLongPress;
  final void Function(PokemonCard? card)? cardDoubleTap;

  void _cardDoubleTap(PokemonCard card) {
    if(cardDoubleTap != null) {
      cardDoubleTap!(card);
    }
  }

  void _cardLongPress(PokemonCard card) {
    if(cardLongPress != null) {
      cardLongPress!(card);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(
          top: appBarheight + 10.0, bottom: bottomTabHeight + 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 2 / 2.8,
      ),
      itemCount: cardsList.length,
      itemBuilder: (BuildContext context, int index) {
        PokemonCard currentCard = cardsList[index];
        return HeroWidget(
          tag: currentCard.uniqueId,
          child: CardRippleFlipAndBadges(
            disableHero: true,
            tag: currentCard.uniqueId,
            currentCard: currentCard,
            cardDoubleTap: () => _cardDoubleTap(currentCard),
            cardLongPress: () => _cardLongPress(currentCard),
          ),
        );
      },
    );
  }
}
