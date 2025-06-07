import 'package:card_keeper/data/models/deck_model.dart';
import 'package:card_keeper/widgets/card_with_ripple.dart';
import 'package:card_keeper/widgets/category_header.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class DeckCategorizedListView extends StatelessWidget {
  final DeckModel deck;
  final void Function(String cardId)? onCardTap;
  final void Function(String cardId)? onCardLongPress;

  const DeckCategorizedListView({
    super.key,
    required this.deck,
    this.onCardTap,
    this.onCardLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final cardsByCategory =
        groupBy(deck.cards, (card) => card.category ?? 'Sem Categoria');

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 100),
      itemCount: cardsByCategory.length,
      itemBuilder: (context, index) {
        final category = cardsByCategory.keys.elementAt(index);
        final cards = cardsByCategory[category]!;

        return Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8.0, 14.0, 8.0),
                child: CategoryHeader(text: category),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 16,
                  children: cards.map((card) {
                    final tag = card.id ?? '${deck.id}-${card.localId ?? ''}';

                    return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: CardWithRipple(
                        tag: tag,
                        imageURL: card.image ?? '',
                        onTap: () => onCardTap?.call(card.id ?? ''),
                        onLongPress: () => onCardLongPress?.call(card.id ?? ''),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
