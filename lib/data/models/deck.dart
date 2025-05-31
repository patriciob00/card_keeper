// To parse this JSON data, do
//
//     final deck = deckFromJson(jsonString);

import 'dart:convert';

import 'package:card_keeper/data/models/deck_card.dart';

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
        deckCards: json["deckCards"] == null ? [] : List<DeckCard>.from(json["deckCards"]!.map((x) => DeckCard.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "deckName": deckName,
        "deckCards": deckCards == null ? [] : List<dynamic>.from(deckCards!.map((x) => x.toJson())),
    };
}