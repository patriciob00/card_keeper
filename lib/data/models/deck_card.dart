import 'dart:convert';

import 'package:card_keeper/data/models/pokemon_card.dart';

DeckCard deckCardFromJson(String str) => DeckCard.fromJson(json.decode(str));

String deckCardToJson(DeckCard data) => json.encode(data.toJson());

class DeckCard {
    String? category;
    int? cardQuantity;
    int? deckRequiredQuantity;
    bool? isAvailableForSale;
    bool? isAvailableForExchange;
    DateTime? addedAt;
    String? id;
    String? illustrator;
    String? image;
    String? localId;
    String? name;
    String? rarity;
    Set? pokemonCardSet;
    Variants? variants;
    List<int>? dexId;
    int? hp;
    List<String>? types;
    String? stage;
    List<Ability>? abilities;
    List<Attack>? attacks;
    List<Weakness>? weaknesses;
    int? retreat;
    Legal? legal;
    DateTime? updated;

    DeckCard({
        this.category,
        this.cardQuantity,
        this.deckRequiredQuantity,
        this.isAvailableForSale,
        this.isAvailableForExchange,
        this.addedAt,
        this.id,
        this.illustrator,
        this.image,
        this.localId,
        this.name,
        this.rarity,
        this.pokemonCardSet,
        this.variants,
        this.dexId,
        this.hp,
        this.types,
        this.stage,
        this.abilities,
        this.attacks,
        this.weaknesses,
        this.retreat,
        this.legal,
        this.updated,
    });

    factory DeckCard.fromJson(Map<String, dynamic> json) => DeckCard(
        category: json["category"],
        cardQuantity: json["card_quantity"],
        deckRequiredQuantity: json["deck_required_quantity"],
        isAvailableForSale: json["isAvailableForSale"],
        isAvailableForExchange: json["isAvailableForExchange"],
        addedAt: json["addedAt"] == null ? DateTime.now() : DateTime.parse(json["addedAt"]),
        id: json["id"],
        illustrator: json["illustrator"],
        image: json["image"],
        localId: json["localId"],
        name: json["name"],
        rarity: json["rarity"],
        pokemonCardSet: json["set"] == null ? null : Set.fromJson(json["set"]),
        variants: json["variants"] == null ? null : Variants.fromJson(json["variants"]),
        dexId: json["dexId"] == null ? [] : List<int>.from(json["dexId"]!.map((x) => x)),
        hp: json["hp"],
        types: json["types"] == null ? [] : List<String>.from(json["types"]!.map((x) => x)),
        stage: json["stage"],
        abilities: json["abilities"] == null ? [] : List<Ability>.from(json["abilities"]!.map((x) => Ability.fromJson(x))),
        attacks: json["attacks"] == null ? [] : List<Attack>.from(json["attacks"]!.map((x) => Attack.fromJson(x))),
        weaknesses: json["weaknesses"] == null ? [] : List<Weakness>.from(json["weaknesses"]!.map((x) => Weakness.fromJson(x))),
        retreat: json["retreat"],
        legal: json["legal"] == null ? null : Legal.fromJson(json["legal"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
    );

    Map<String, dynamic> toJson() => {
        "category": category,
        "card_quantity": cardQuantity,
        "deck_required_quantity": deckRequiredQuantity,
        "isAvailableForSale": isAvailableForSale,
        "isAvailableForExchange": isAvailableForExchange,
        "addedAt": addedAt == null ? DateTime.now().toIso8601String() : addedAt?.toIso8601String(),
        "id": id,
        "illustrator": illustrator,
        "image": image,
        "localId": localId,
        "name": name,
        "rarity": rarity,
        "set": pokemonCardSet?.toJson(),
        "variants": variants?.toJson(),
        "dexId": dexId == null ? [] : List<dynamic>.from(dexId!.map((x) => x)),
        "hp": hp,
        "types": types == null ? [] : List<dynamic>.from(types!.map((x) => x)),
        "stage": stage,
        "abilities": abilities == null ? [] : List<dynamic>.from(abilities!.map((x) => x.toJson())),
        "attacks": attacks == null ? [] : List<dynamic>.from(attacks!.map((x) => x.toJson())),
        "weaknesses": weaknesses == null ? [] : List<dynamic>.from(weaknesses!.map((x) => x.toJson())),
        "retreat": retreat,
        "legal": legal?.toJson(),
        "updated": updated?.toIso8601String(),
    };
}