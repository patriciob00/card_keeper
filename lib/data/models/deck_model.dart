import 'dart:convert';
import 'package:card_keeper/data/models/deck_card.dart';

class DeckModel {
  final String id;
  final String name;
  final List<DeckCard> cards;
  final DateTime createdAt;

  DeckModel({
    required this.id,
    required this.name,
    required this.cards,
    required this.createdAt,
  });

  factory DeckModel.fromJson(Map<String, dynamic> json) => DeckModel(
        id: json['id'],
        name: json['name'],
        cards: List<DeckCard>.from(
          json['cards'].map((x) => DeckCard.fromJson(x)),
        ),
        createdAt: DateTime.parse(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'cards': List<dynamic>.from(cards.map((x) => x.toJson())),
        'createdAt': createdAt.toIso8601String(),
      };

  // Utilitários opcionais para conversão de/para string JSON
  static DeckModel fromRawJson(String str) => DeckModel.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());
}