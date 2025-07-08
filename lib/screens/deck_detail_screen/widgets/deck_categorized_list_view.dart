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
    
    const int columnCount = 2;
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.04; // ~16 px
    final spacing = screenWidth * 0.04; // mesmo valor que o padding
    final double cardWidth = (screenWidth - (horizontalPadding) - ((spacing) * (columnCount))) / columnCount;

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
                padding: const EdgeInsets.fromLTRB(0, 8.0, 0.0, 8.0),
                child: CategoryHeader(text: category),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: cards.map((card) {
                    final tag = card.id ?? '${deck.id}-${card.localId ?? ''}';

                    return SizedBox(
                      width: cardWidth,
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
