import 'dart:convert';

import 'package:card_keeper/data/models/card_list_item_model.dart';
import 'package:card_keeper/data/models/pokemon_card.dart';
import 'package:dio/dio.dart';

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

  Future<PokemonCard?> getCardById(String cardId) async {
    final client = Dio();
    final response = await client.get('https://api.tcgdex.net/v2/pt/cards/$cardId');

    if(response.statusCode == 200) {
      return PokemonCard.fromJson(response.data);
    }

    return null;
  }
}