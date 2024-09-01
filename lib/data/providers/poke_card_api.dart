import 'dart:convert';

import 'package:card_keeper/data/models/card_list_item_model.dart';

import 'package:http/http.dart' as http;

class PokeCardApi {
  Future<List<CardListItem>?> searchCard(String searchterm) async {
    var client = http.Client();
    var uri = Uri.parse('https://api.tcgdex.net/v2/pt/cards?name=$searchterm');

    var response = await client.get(uri);
    if(response.statusCode == 200) {
      return cardListItemFromJson(const Utf8Decoder().convert(response.bodyBytes));
    }
    return null;
  }
}