import 'package:card_keeper/data/models/pokemon_card.dart';
import 'package:card_keeper/data/models/card_list_item_model.dart';

extension CardListItemMapper on CardListItem {
  PokemonCard toPokemonCard() {
    return PokemonCard(
      id: id,
      name: name,
      image: image,
      localId: localId,
      cardQuantity: 0, // default para adição no deck
    );
  }
}