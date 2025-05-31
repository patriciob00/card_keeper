import 'package:card_keeper/data/models/card_list_item_model.dart';
import 'package:card_keeper/repositories/deck_cards_notifier.dart';
import 'package:card_keeper/screens/create_deck_screen/widgets/card_badge_custom.dart';
import 'package:card_keeper/widgets/hero_widget.dart';
import 'package:card_keeper/widgets/image_cached.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'show_add_to_deck_bottom_sheet.dart';

class SearchCardsList extends ConsumerWidget {
  const SearchCardsList({
    super.key,
    required this.cardList,
  });

  final List<CardListItem>? cardList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Flexible(
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          // mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 2 / 3,
        ),
        itemCount: cardList!.length,
        itemBuilder: (BuildContext context, int index) {
          final card = cardList![index];
          final deckCard = ref
              .watch(deckCardsProvider)
              .firstWhereOrNull((c) => c.id == card.id);
          return GestureDetector(
              onTap: () {
                showAddToDeckBottomSheet(
                  context: context,
                  ref: ref,
                  card: card,
                );
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  HeroWidget(
                    tag: cardList![index].image ?? '',
                    child: ImageCached(imageURL: cardList![index].image ?? ''),
                  ),
                  if (deckCard != null &&
                      (deckCard.deckRequiredQuantity ?? 0) > 0)
                    Positioned(
                        top: -5,
                        right: -3,
                        child: CardBadgeCustom(
                    child: Text(
                      deckCard.deckRequiredQuantity.toString(),
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),)
                ],
              ));
        },
      ),
    );
  }
}
