import 'dart:convert';

import 'package:card_keeper/data/models/deck_card.dart';
import 'package:card_keeper/data/models/pokemon_card.dart';

Deck deckFromJson(String str) => Deck.fromJson(json.decode(str));

String deckToJson(Deck data) => json.encode(data.toJson());

class Deck {
  String? deckName;
  List<DeckCard>? deckCards;
  String id;

  Deck({
    this.deckName,
    this.deckCards,
    required this.id,
  });

  factory Deck.fromJson(Map<String, dynamic> json) => Deck(
        id: json["id"],
        deckName: json["deckName"],
        deckCards: json["deckCards"] == null
            ? []
            : List<DeckCard>.from(
                json["deckCards"]!.map((x) => DeckCard.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "deckName": deckName,
        "deckCards": deckCards == null
            ? []
            : List<dynamic>.from(deckCards!.map((x) => x.toJson())),
      };

  /// Retorna um mapa: id da carta → (quantidade possuída, quantidade necessária no deck)
  Map<String, (int owned, int required)> getCompletionStatus(
      List<PokemonCard> ownedCards) {
    final Map<String, (int, int)> status = {};

    for (final deckCard in deckCards ?? []) {
      final required = deckCard.deckRequiredQuantity ?? 0;

      // Busca na coleção a carta correspondente
      final ownedCard = ownedCards.firstWhere(
        (card) => card.id == deckCard.id,
        orElse: () => PokemonCard(id: deckCard.id, cardQuantity: 0),
      );

      final owned = ownedCard.cardQuantity ?? 0;

      status[deckCard.id ?? ""] = (owned, required);
    }

    return status;
  }

  /// Retorna true se o deck está completo (todas as cartas têm quantidade suficiente)
  bool isComplete(List<PokemonCard> ownedCards) {
    return getCompletionStatus(ownedCards)
        .values
        .every((tuple) => tuple.$1 >= tuple.$2);
  }
}
