// To parse this JSON data, do
//
//     final pokemonCard = pokemonCardFromJson(jsonString);

import 'dart:convert';

PokemonCard pokemonCardFromJson(String str) => PokemonCard.fromJson(json.decode(str));

String pokemonCardToJson(PokemonCard data) => json.encode(data.toJson());

class PokemonCard {
    String? category;
    int? cardQuantity;
    bool? isAvailableForSale;
    bool? isAvailableForExchange;
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

    PokemonCard({
        this.category,
        this.cardQuantity,
        this.isAvailableForSale,
        this.isAvailableForExchange,
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

    factory PokemonCard.fromJson(Map<String, dynamic> json) => PokemonCard(
        category: json["category"],
        cardQuantity: json["card_quantity"],
        isAvailableForSale: json["isAvailableForSale"],
        isAvailableForExchange: json["isAvailableForExchange"],
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
        "isAvailableForSale": isAvailableForSale,
        "isAvailableForExchange": isAvailableForExchange,
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

class Ability {
    String? type;
    String? name;
    String? effect;

    Ability({
        this.type,
        this.name,
        this.effect,
    });

    factory Ability.fromJson(Map<String, dynamic> json) => Ability(
        type: json["type"],
        name: json["name"],
        effect: json["effect"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "effect": effect,
    };
}

class Attack {
    List<String>? cost;
    String? name;
    String? effect;
    String? damage;

    Attack({
        this.cost,
        this.name,
        this.effect,
        this.damage,
    });

    factory Attack.fromJson(Map<String, dynamic> json) => Attack(
        cost: json["cost"] == null ? [] : List<String>.from(json["cost"]!.map((x) => x)),
        name: json["name"],
        effect: json["effect"],
        damage: json["damage"].toString(),
    );

    Map<String, dynamic> toJson() => {
        "cost": cost == null ? [] : List<dynamic>.from(cost!.map((x) => x)),
        "name": name,
        "effect": effect,
        "damage": damage,
    };
}

class Legal {
    bool? standard;
    bool? expanded;

    Legal({
        this.standard,
        this.expanded,
    });

    factory Legal.fromJson(Map<String, dynamic> json) => Legal(
        standard: json["standard"],
        expanded: json["expanded"],
    );

    Map<String, dynamic> toJson() => {
        "standard": standard,
        "expanded": expanded,
    };
}

class Set {
    CardCount? cardCount;
    String? id;
    String? name;
    String? symbol;

    Set({
        this.cardCount,
        this.id,
        this.name,
        this.symbol,
    });

    factory Set.fromJson(Map<String, dynamic> json) => Set(
        cardCount: json["cardCount"] == null ? null : CardCount.fromJson(json["cardCount"]),
        id: json["id"],
        name: json["name"],
        symbol: json["symbol"],
    );

    Map<String, dynamic> toJson() => {
        "cardCount": cardCount?.toJson(),
        "id": id,
        "name": name,
        "symbol": symbol,
    };
}

class CardCount {
    int? official;
    int? total;

    CardCount({
        this.official,
        this.total,
    });

    factory CardCount.fromJson(Map<String, dynamic> json) => CardCount(
        official: json["official"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "official": official,
        "total": total,
    };
}

class Variants {
    bool? firstEdition;
    bool? holo;
    bool? normal;
    bool? reverse;
    bool? wPromo;

    Variants({
        this.firstEdition,
        this.holo,
        this.normal,
        this.reverse,
        this.wPromo,
    });

    factory Variants.fromJson(Map<String, dynamic> json) => Variants(
        firstEdition: json["firstEdition"],
        holo: json["holo"],
        normal: json["normal"],
        reverse: json["reverse"],
        wPromo: json["wPromo"],
    );

    Map<String, dynamic> toJson() => {
        "firstEdition": firstEdition,
        "holo": holo,
        "normal": normal,
        "reverse": reverse,
        "wPromo": wPromo,
    };
}

class Weakness {
    String? type;
    String? value;

    Weakness({
        this.type,
        this.value,
    });

    factory Weakness.fromJson(Map<String, dynamic> json) => Weakness(
        type: json["type"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "value": value,
    };
}
