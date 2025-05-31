import 'package:card_keeper/data/models/deck_model.dart';
import 'package:card_keeper/repositories/pokemon_cards_repository.dart';
import 'package:card_keeper/widgets/hero_widget.dart';
import 'package:card_keeper/widgets/image_cached.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

class DeckGridItem extends ConsumerWidget {
  final DeckModel deck;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const DeckGridItem({
    super.key,
    required this.deck,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userCards = ref.watch(pokemonCardsRepositoryProvider);
    final coverCard = deck.cards.isNotEmpty ? deck.cards.first : null;

    final completed = deck.cards.every((deckCard) {
      final userCard = userCards.firstWhereOrNull((uc) => uc.id == deckCard.id);
      if (userCard == null) return false;

      return (userCard.cardQuantity ?? 0) >= (deckCard.deckRequiredQuantity ?? 0);
    });

    final opacity = completed ? 1.0 : 0.5;
    final imageUrl = coverCard?.image ?? '';

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;

        return Stack(
          children: [
            // Imagem com opacidade
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Opacity(
                opacity: opacity,
                child: HeroWidget(
                  tag: imageUrl,
                  child: ImageCached(
                    imageURL: imageUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Nome do deck
            Positioned(
              bottom: 8,
              left: cardWidth * 0.05,
              right: cardWidth * 0.05,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      offset: Offset(0, 2),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Text(
                  deck.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),

            // Efeito ripple e clique
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: onTap,
                  onLongPress: onLongPress,
                  splashColor: Colors.white24,
                  highlightColor: Colors.white10,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}