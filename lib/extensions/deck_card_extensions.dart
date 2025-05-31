import 'package:card_keeper/data/models/card_list_item_model.dart';
import 'package:card_keeper/data/models/deck_card.dart';
import 'package:card_keeper/data/models/pokemon_card.dart';

extension DeckCardMapper on DeckCard {
  static DeckCard fromPokemonCard(PokemonCard card) {
    return DeckCard(
      id: card.id,
      name: card.name,
      image: card.image,
      category: card.category,
      cardQuantity: card.cardQuantity,
      isAvailableForSale: card.isAvailableForSale,
      isAvailableForExchange: card.isAvailableForExchange,
      addedAt: card.addedAt,
      illustrator: card.illustrator,
      localId: card.localId,
      rarity: card.rarity,
      pokemonCardSet: card.pokemonCardSet,
      variants: card.variants,
      dexId: card.dexId,
      hp: card.hp,
      types: card.types,
      stage: card.stage,
      abilities: card.abilities,
      attacks: card.attacks,
      weaknesses: card.weaknesses,
      retreat: card.retreat,
      legal: card.legal,
      updated: card.updated,
    );
  }
}


extension DeckCardCopyWith on DeckCard {
  DeckCard copyWith({
    String? category,
    int? cardQuantity,
    int? deckRequiredQuantity,
    bool? isAvailableForSale,
    bool? isAvailableForExchange,
    DateTime? addedAt,
    String? id,
    String? illustrator,
    String? image,
    String? localId,
    String? name,
    String? rarity,
    Set? pokemonCardSet,
    Variants? variants,
    List<int>? dexId,
    int? hp,
    List<String>? types,
    String? stage,
    List<Ability>? abilities,
    List<Attack>? attacks,
    List<Weakness>? weaknesses,
    int? retreat,
    Legal? legal,
    DateTime? updated,
  }) {
    return DeckCard(
      category: category ?? this.category,
      cardQuantity: cardQuantity ?? this.cardQuantity,
      deckRequiredQuantity: deckRequiredQuantity ?? this.deckRequiredQuantity,
      isAvailableForSale: isAvailableForSale ?? this.isAvailableForSale,
      isAvailableForExchange: isAvailableForExchange ?? this.isAvailableForExchange,
      addedAt: addedAt ?? this.addedAt,
      id: id ?? this.id,
      illustrator: illustrator ?? this.illustrator,
      image: image ?? this.image,
      localId: localId ?? this.localId,
      name: name ?? this.name,
      rarity: rarity ?? this.rarity,
      pokemonCardSet: pokemonCardSet ?? this.pokemonCardSet,
      variants: variants ?? this.variants,
      dexId: dexId ?? this.dexId,
      hp: hp ?? this.hp,
      types: types ?? this.types,
      stage: stage ?? this.stage,
      abilities: abilities ?? this.abilities,
      attacks: attacks ?? this.attacks,
      weaknesses: weaknesses ?? this.weaknesses,
      retreat: retreat ?? this.retreat,
      legal: legal ?? this.legal,
      updated: updated ?? this.updated,
    );
  }
}

extension DeckCardToCardListItem on DeckCard {
  CardListItem toCardListItem() {
    return CardListItem(
      id: id,
      name: name,
      image: image,
      localId: localId,
    );
  }
}