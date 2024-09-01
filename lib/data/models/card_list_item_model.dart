// To parse this JSON data, do
//
//     final cardListItem = cardListItemFromJson(jsonString);

import 'dart:convert';

List<CardListItem> cardListItemFromJson(String str) => List<CardListItem>.from(
    json.decode(str).map((x) => CardListItem.fromJson(x))).where((el) => el.image != null).toList();

String cardListItemToJson(List<CardListItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CardListItem {
  String? id;
  String? localId;
  String? name;
  String? image;

  CardListItem({
    this.id,
    this.localId,
    this.name,
    this.image,
  });

  factory CardListItem.fromJson(Map<String, dynamic> json) => CardListItem(
        id: json["id"],
        localId: json["localId"],
        name: json["name"],
        image: json["image"] != null ? json["image"] + '/high.webp' : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "localId": localId,
        "name": name,
        "image": image,
      };
}
