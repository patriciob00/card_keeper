import 'package:card_keeper/data/models/pokemon_card.dart';
import 'package:card_keeper/widgets/card_with_ripple_and_flip.dart';
import 'package:flutter/material.dart';

class CardsGridView extends StatelessWidget {
  const CardsGridView({
    super.key,
    required this.appBarheight,
    required this.bottomTabHeight,
    required this.cardsList,
    required this.cardLongPressDialog,
    required this.getBadges,
  });

  final double appBarheight;
  final double bottomTabHeight;
  final List<PokemonCard> cardsList;
  final Function(PokemonCard card) cardLongPressDialog;
  final List<Widget> Function(PokemonCard card) getBadges;

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
        return Stack(clipBehavior: Clip.none, children: [
          CardWithRippleAndFlip(
            isAlreadyOnList: true,
            currentPokemon: cardsList[index],
            tag: cardsList[index].image ?? '',
            imageURL: cardsList[index].image ?? '',
            onLongPress: () => cardLongPressDialog(cardsList[index]),
          ),
          Positioned(
              top: -12,
              right: 3,
              child: Row(
                textDirection: TextDirection.rtl,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: getBadges(cardsList[index]),
              ))
        ]);
      },
    );
  }
}
