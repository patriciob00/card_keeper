import 'package:card_keeper/data/models/card_variant.dart';
import 'package:card_keeper/data/models/pokemon_card.dart';
import 'package:card_keeper/screens/cards_list_screen/widgets/badge_custom.dart';
import 'package:card_keeper/widgets/card_with_ripple_and_flip.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class CardRippleFlipAndBadges extends StatelessWidget {
  const CardRippleFlipAndBadges({
    super.key,
    required this.currentCard,
    this.cardLongPress,
    this.cardTap,
    this.cardDoubleTap,
    this.tag,
    this.disableHero = false,
  });

  final PokemonCard currentCard;
  final String? tag;
  final bool? disableHero;
  final void Function()? cardLongPress;
  final void Function()? cardTap;
  final void Function()? cardDoubleTap;

  List<Widget> getBadges(PokemonCard card) {
    List<Widget> list = [];

    list.add(BadgeCustom(
        child: Text(
      card.cardQuantity.toString(),
      style: const TextStyle(
          fontSize: 12.0, color: Colors.black, fontWeight: FontWeight.bold),
    )));

    if (card.isAvailableForSale!) {
      list.add(const BadgeCustom(
        child: Icon(
          Symbols.attach_money_sharp,
          color: Colors.green,
          size: 12.0,
        ),
      ));
    }

    if (card.isAvailableForExchange!) {
      list.add(const BadgeCustom(
        child: Icon(
          Symbols.sync_alt_sharp,
          color: Colors.orange,
          size: 12.0,
        ),
      ));
    }

    final variant = card.variant ?? CardVariant.normal;
    if (variant != CardVariant.normal) {
      final bool isHoloVariant = variant == CardVariant.holo;
      list.add(BadgeCustom(
          child: Text(
        isHoloVariant ? 'H' : 'R',
        style: TextStyle(
            fontSize: 12.0,
            color: isHoloVariant ? Colors.deepPurple : Colors.deepOrange,
            fontWeight: FontWeight.bold),
      )));
    }
    return list;
  }

  
  
  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
          CardWithRippleAndFlip(
            disableHero: disableHero,
            isAlreadyOnList: true,
            currentCard: currentCard,
            tag: tag ?? currentCard.image ?? '',
            imageURL: currentCard.image ?? '',
            onTap: cardTap,
            onDoubleTap: cardDoubleTap,
            onLongPress: cardLongPress,
          ),
          Positioned(
              top: -12,
              child: Row(
                textDirection: TextDirection.rtl,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: getBadges(currentCard),
              ))
        ]);
  }

}