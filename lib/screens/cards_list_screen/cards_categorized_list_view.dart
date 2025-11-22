import 'package:card_keeper/data/models/pokemon_card.dart';
import 'package:card_keeper/widgets/card_ripple_flip_and_badges.dart';
import 'package:card_keeper/widgets/category_header.dart';
import 'package:card_keeper/widgets/hero_widget.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class CardsCategorizedListView extends StatelessWidget {
  const CardsCategorizedListView({
    super.key,
    required this.cards,
    this.onTap,
    this.onLongPress,
    this.buildBadgeOverlay, // opcional: reaproveitar seus “badges” da grade
  });

  final List<PokemonCard> cards;
  final void Function(PokemonCard card)? onTap;
  final void Function(PokemonCard card)? onLongPress;
  final Widget Function(PokemonCard card)? buildBadgeOverlay;

  @override
  Widget build(BuildContext context) {
    final grouped = groupBy(cards, (c) => c.category ?? 'Sem categoria');

    return LayoutBuilder(
      builder: (context, constraints) {
        // 2 colunas fixas como na grade
        const cols = 2;
        // largura do item baseada no padrão da sua grade (≈ 0.43 do width)
        final itemWidth = constraints.maxWidth * 0.48;
        // calcula o espaçamento horizontal p/ ficar simétrico nas bordas
        final totalItemsWidth = itemWidth * cols;
        final spaceForGaps = constraints.maxWidth - totalItemsWidth;
        final hSpacing = spaceForGaps;
        final vSpacing = hSpacing; // mantém proporção agradável

        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 100),
          itemCount: grouped.length,
          itemBuilder: (_, i) {
            final category = grouped.keys.elementAt(i);
            final list = grouped[category]!
              ..sort(
                (a, b) => (b.addedAt ?? DateTime(2000))
                    .compareTo(a.addedAt ?? DateTime(2000)),
              );

            return Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cabeçalho estilizado que você já usa
                  const SizedBox(height: 8),
                  CategoryHeader(text: category),
                  const SizedBox(height: 12),

                  // Grid “solta” com Wrap
                  Wrap(
                    spacing: hSpacing,
                    runSpacing: vSpacing,
                    children: list.map((card) {

                      return SizedBox(
                        width: itemWidth,
                        height: itemWidth * 1.4,
                        child: HeroWidget(
                          tag: card.uniqueId,
                          child: CardRippleFlipAndBadges(
                            disableHero: true,
                            tag: card.uniqueId,
                            currentCard: card,
                            cardLongPress: () =>
                                onLongPress != null ? onLongPress!(card) : null,
                            cardDoubleTap: () =>
                                onLongPress != null ? onLongPress!(card) : null,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
