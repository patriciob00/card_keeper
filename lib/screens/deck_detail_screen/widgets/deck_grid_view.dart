import 'package:card_keeper/data/models/deck_model.dart';
import 'package:card_keeper/widgets/card_with_ripple/main.dart';
import 'package:flutter/material.dart';

class DeckGridView extends StatelessWidget {
  final DeckModel deck;
  final void Function(String cardId)? onCardTap;
  final void Function(String cardId)? onCardLongPress;

  const DeckGridView({
    super.key,
    required this.deck,
    this.onCardTap,
    this.onCardLongPress,
  });
  @override
  Widget build(BuildContext context) {
    final deckId = deck.id;
    final cards = deck.cards;
    final firstCard = deck.cards.isNotEmpty ? deck.cards.first : null;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        itemCount: cards.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 6,
          childAspectRatio: 2 / 2.9,
        ),
        itemBuilder: (context, index) {
          final currentCard = cards[index];
          return CardWithRipple(
            tag: (currentCard.id ?? '') == (firstCard?.id ?? '')
                ? deckId
                : (currentCard.id ?? '$deckId-${currentCard.localId ?? ''}'),
            imageURL: currentCard.image ?? '',
            onLongPress: () {},
          );
        },
      ),
    );
  }
}
