import 'dart:convert';

import 'package:card_keeper/data/models/deck_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeckStorage {
  static const String deckListKey = 'deck_list';

  Future<void> saveDeck(DeckModel deck) async {
    List<DeckModel> decks = await getDeckList();
    decks.add(deck);
    await _saveDeckList(decks);
  }

  Future<void> updateDeck(DeckModel updatedDeck) async {
    List<DeckModel> decks = await getDeckList();
    int index = decks.indexWhere((d) => d.id == updatedDeck.id);
    if (index != -1) {
      decks[index] = updatedDeck;
      await _saveDeckList(decks);
    }
  }

  Future<void> removeDeck(String deckId) async {
    List<DeckModel> decks = await getDeckList();
    decks.removeWhere((d) => d.id == deckId);
    await _saveDeckList(decks);
  }

  Future<void> _saveDeckList(List<DeckModel> decks) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonStringList =
        decks.map((deck) => json.encode(deck.toJson())).toList();
    await prefs.setStringList(deckListKey, jsonStringList);
  }

  Future<List<DeckModel>> getDeckList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonStringList = prefs.getStringList(deckListKey);

    if (jsonStringList != null) {
      return jsonStringList
          .map((jsonString) => DeckModel.fromJson(json.decode(jsonString)))
          .toList();
    }
    return [];
  }
}